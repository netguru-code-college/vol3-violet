class AvatarUploader < CarrierWave::Uploader::Base
  # Choose what kind of storage to use for this uploader:
  storage :file

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # validate extensions of avatars
  def extension_whitelist
    %w[jpg jpeg gif png]
  end

  # validate size of avatar
  def size_range
    1..10.megabytes
  end
end
