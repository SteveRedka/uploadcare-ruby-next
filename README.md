# Ruby integration for Uploadcare

<p align="left">
    <a href="LICENSE">
        <img src="https://img.shields.io/badge/license-MIT-brightgreen.svg" alt="MIT License">
    </a>
</p>

Uploadcare Ruby integration handles uploads and further operations with files by
wrapping Upload and REST APIs.

* [Installation](#installation)
* [Usage](#usage)
* [Configuration](#configuration)
* [Development](DEVELOPMENT.md)
* [Useful links](#useful-links)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'uploadcare-ruby'
```

And then execute:

    $ bundle

Create your project in [Uploadcare dashboard](https://uploadcare.com/dashboard/)
and copy its API keys from there.

Set your Uploadcare keys in config file or through environment variables
`UPLOADCARE_PUBLIC_KEY` and `UPLOADCARE_SECRET_KEY`, or [configure your app yourself](#Configuration) if you are using
different way of storing keys.

```bash
export UPLOADCARE_PUBLIC_KEY=demopublickey
export UPLOADCARE_SECRET_KEY=demoprivatekey
```

## Usage

This section contains practical usage examples. Please note,
everything that follows gets way more clear once you've looked
through our docs [intro](https://uploadcare.com/documentation/).

### Basic usage: uploading a single file, manipulations

Using Uploadcare is simple, and here are the basics of handling files.
```ruby
# Create API object
@api = Uploadcare::Api.new

# Upload file
@file_to_upload = File.open("your-file.png")

@uc_file.uuid
# => "dc99200d-9bd6-4b43-bfa9-aa7bfaefca40"

# URL for the file, can be used with your website or app right away
@uc_file.cdn_url
# => "https://ucarecdn.com/dc99200d-9bd6-4b43-bfa9-aa7bfaefca40/"
```

Your might then want to store or delete the uploaded file.
Storing files could be crucial if you aren't using the
“Automatic file storing” option for your Uploadcare project.
If not stored manually or automatically, files get deleted
within a 24-hour period.

```ruby
# that's how you store a file
@uc_file.store
# => #<Uploadcare::Api::File ...

# and that works for deleting it
@uc_file.delete
# => #<Uploadcare::Api::File ...
```

### Uploads
Uploadcare supports multiple ways to upload files
```ruby
# Smart upload - detects type of passed object and picks appropriate upload method
@api.upload('https://placekitten.com/96/139')
```
There are explicit ways to select upload type:
```ruby
@api.upload_from_url('https://placekitten.com/96/139')

files = [File.open('1.jpg'), File.open('1.jpg']
@api.upload_files(files)

# multipart upload - can be useful for files bigger than 10 mb
@api.multipart_upload(File.open('big_file.bin'))
```

### Upload options

You can override global [`:autostore`](#initialization) option for each upload request:

```ruby
@api.upload(files, store: true)
@api.upload_from_url(url, store: :auto)
```

### Entity object
Entities are representations of objects in Uploadcare cloud.

#### File
File entity, gotten from `@api.file` or `@api.upload_one`, contains its metadata.

```ruby
@file = @api.file('8f64f313-e6b1-4731-96c0-6751f1e7a50a')
{"datetime_removed"=>nil,
 "datetime_stored"=>"2020-01-16T15:03:15.315064Z",
 "datetime_uploaded"=>"2020-01-16T15:03:14.676902Z",
 "image_info"=>
  {"color_mode"=>"RGB",
   "orientation"=>nil,
   "format"=>"JPEG",
   "sequence"=>false,
   "height"=>183,
   "width"=>190,
   "geo_location"=>nil,
   "datetime_original"=>nil,
   "dpi"=>nil},
 "is_image"=>true,
 "is_ready"=>true,
 "mime_type"=>"image/jpeg",
 "original_file_url"=>
  "https://ucarecdn.com/8f64f313-e6b1-4731-96c0-6751f1e7a50a/imagepng.jpeg",
 "original_filename"=>"image.png.jpeg",
 "size"=>5345,
 "url"=>
  "https://api.uploadcare.com/files/8f64f313-e6b1-4731-96c0-6751f1e7a50a/",
 "uuid"=>"8f64f313-e6b1-4731-96c0-6751f1e7a50a"}

@file.store # stores file, returns updated metadata

@file.delete #deletes file. Returns updated metadata
```
Metadata of deleted files is stored permanently

#### FileList
`Uploadcare::Api::FileList` represents the whole collection of files (or it's subset) and privides a way to iterate through it, making pagination transparent. FileList objects can be created using `Uploadcare::Api#file_list` method.

```ruby
@list = @api.file_list # => instance of Uploadcare::Api::FileList
```

This method accepts some options to controll which files should be fetched and how they should be fetched:

- **:limit** - Controls page size. Accepts values from 1 to 1000, defaults to 100.
- **:stored** - Can be either `true` or `false`. When true, file list will contain only stored files. When false - only not stored.
- **:removed** - Can be either `true` or `false`. When true, file list will contain only removed files. When false - all except removed. Defaults to false.
- **:ordering** - Controls the order of returned files. Available values: `datetime_updated`, `-datetime_updated`, `size`, `-size`. Defaults to `datetime_uploaded`. More info can be found [here](https://uploadcare.com/documentation/rest/#file-files)
- **:from** - Specifies the starting point for a collection. Resulting collection will contain files from the given value and to the end in a direction set by an **ordering** option. When files are ordered by datetime_updated in any direction, accepts either a `DateTime` object or an ISO 8601 string. When files are ordered by size, acepts non-negative integers (size in bytes). More info can be found [here](https://uploadcare.com/documentation/rest/#file-files)

Options used to create a file list can be accessed through `#options` method. Note that, once set, they don't affect file fetching process anymore and are stored just for your convenience. That is why they are frozen.

```ruby
options = {
  limit: 10,
  stored: true,
  ordering: '-datetime_uploaded',
  from: "2017-01-01T00:00:00",
}
@list = @api.file_list(options)
```

#### Group
Groups are structures intended to organize sets of separate files.
Each group is assigned UUID.
Note, group UUIDs include a `~#{files_count}` part at the end.
That's a requirement of our API.

```ruby
# group can be created from an array of Uploadcare files
@files_ary = [@file, @file2]
@files = @api.upload @files_ary
@group = @api.create_group @files
```

#### Webhook
https://uploadcare.com/docs/api_reference/rest/webhooks/

You can use webhooks to provide notifications about your uploads to target urls.
This gem lets you create and manage webhooks.
```ruby

```

#### Project
`Project` provides basic info about the connected Uploadcare project.
That object is also an Hashie::Mash, so every methods out of
[these](https://uploadcare.com/documentation/rest/#project) will work.
```ruby
@project = @api.project
# => #<Uploadcare::Api::Project collaborators=[], name="demo", pub_key="demopublickey", autostore_enabled=true>

@project.name
# => "demo"

@project.collaborators
# => []
# while that one was empty, it usually goes like this:
# [{"email": collaborator@gmail.com, "name": "Collaborator"}, {"email": collaborator@gmail.com, "name": "Collaborator"}]
```

## Configuration
Gem configuration is available in `Uploadcare.configuration`. Full list of settings can be seen in [`lib/uploadcare/default_configuration.rb`](lib/uploadcare/default_configuration.rb)

## Development

See [DEVELOPMENT.md](/DEVELOPMENT.md)  

## Useful links

[Uploadcare documentation](https://uploadcare.com/docs/)  
[Upload API reference](https://uploadcare.com/api-refs/upload-api/)  
[REST API reference](https://uploadcare.com/api-refs/rest-api/)  
[Changelog](/CHANGELOG.md)  
[Contributing guide](https://github.com/uploadcare/.github/blob/master/CONTRIBUTING.md)  
[Security policy](https://github.com/uploadcare/uploadcare-ruby/security/policy)  
[Support](https://github.com/uploadcare/.github/blob/master/SUPPORT.md)  
