# app/helpers/flats_helper.rb
module FlatsHelper
  # Renders the cover image for a flat:
  # - Cloudinary (Active Storage service): uses cl_image_tag with transformations
  # - photo_url string: plain image_tag
  # - else: placeholder
  #
  # size: [width, height] for cropping (default: 800x500)
  def flat_cover_image_tag(flat, size: [800, 500], html: {})
    alt_text = flat.try(:title) || flat.try(:name) || "Flat"
    width, height = size

    # has_many_attached :photos
    if flat.respond_to?(:photos) && flat.photos.attached?
      blob = flat.photos.first.blob
      return cloudinary_or_original_image(blob, width, height, alt_text, html)

    # has_one_attached :photo
    elsif flat.respond_to?(:photo) && flat.photo.attached?
      blob = flat.photo.blob
      return cloudinary_or_original_image(blob, width, height, alt_text, html)

    # string URL fallback
    elsif flat.respond_to?(:photo_url) && flat.photo_url.present?
      return image_tag(flat.photo_url, { alt: alt_text }.merge(html))
    else
      return image_tag("placeholder.jpg", { alt: "No image available" }.merge(html))
    end
  rescue StandardError
    # Any unexpected processing failure -> show placeholder instead of blowing up
    image_tag("placeholder.jpg", { alt: "No image available" }.merge(html))
  end

  private

  # If the Active Storage service is Cloudinary, render via cl_image_tag for crisp transforms.
  # Otherwise, fall back to the original blob URL (no variant processing to avoid IntegrityError).
  def cloudinary_or_original_image(blob, width, height, alt_text, html)
    if defined?(Cloudinary) && blob.respond_to?(:key)
      # Active Storage + Cloudinary: blob.key is the Cloudinary public_id
      cl_image_tag(
        blob.key,
        { width: width, height: height, crop: :fill, gravity: :auto, fetch_format: :auto, quality: :auto }
          .merge(html)
          .merge(alt: alt_text)
      )
    else
      # Non-Cloudinary service: just show the original file without processing
      image_tag(url_for(blob), { alt: alt_text }.merge(html))
    end
  end
end
