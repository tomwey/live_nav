CarrierWave.configure do |config|
  config.asset_host = Setting.upload_url
end

# encoding: utf-8

::CarrierWave.configure do |config|
  config.storage              = :qiniu
  config.qiniu_access_key     = Setting.qiniu_access_key
  config.qiniu_secret_key     = Setting.qiniu_secret_key
  config.qiniu_bucket         = Setting.qiniu_bucket
  config.qiniu_bucket_domain  = Setting.qiniu_bucket_domain
  config.qiniu_bucket_private = true #default is false
  config.qiniu_block_size     = 4*1024*1024
  config.qiniu_private_url_expires_in = 10 * 365 * 24 * 3600 # 设置token失效时间
  config.qiniu_protocol       = "http"
end