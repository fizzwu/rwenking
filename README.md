RWenking
========

This is a Ruby REST Client for taobao's anti-phishing system called wenking

Install
-------

```bash
$ gem install rwenking
```

Configure
---------

create `wenking.yml` in your app's config directory

```yaml
development:
  appname: 'xxx'
  appkey: 'xxx'

production:
  appname: 'xxx'
  appkey: 'xxx'
```
create an initializer called `wenking.rb` in your rails initializers directory

```ruby
# -*- encoding : utf-8 -*-
require 'rwenking'

$wenking_config = YAML.load_file("#{Rails.root}/config/wenking.yml")[Rails.env]
$wenking = RWenking::Client.new(:appname => $wenking_config['appname'], :appkey => $wenking_config['appkey'])
```

Usage
-----

upload a url to wenking, if success, you'll get response `1`

```ruby
url = "http://xxx" # the url you want to check
extradata = '{"post_id":"335"}' # a json object with content whatever you want, so you can get it when you call the get_phish api later
$wenking.scan(:url => url, :extradata => extradata)
```
get detection result by the `get_phish` api, it returns a hash array with all phish urls in it

```ruby
# return all results from id=0
arr = $wenking.get_phish

# return results from id=100, everytime you got the result, you'd better save the biggest id, so next time you call this api, you'll get the new results after this id
arr = $wenking.get_phish(100)

arr.each do |item|
  puts item["id"] # result id
  puts item["url"] # phish url
  puts item["extradata"] #extradata you have posted in scan api 
end
```



