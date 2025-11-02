# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'open-uri'

puts "🧹 Clearing existing data..."
Flat.destroy_all
User.destroy_all

puts "👤 Creating a users"
users = [
  { email: "nasjwa@example.com", password: "123456" },
  { email: "jean@example.com", password: "123456" },
  { email: "goncalo@example.com", password: "123456" }
].map { |attrs| User.create!(attrs) }

def attach_photos(flat, urls)
  urls.each do |url|
    begin
      file = URI.open(url, open_timeout: 10, read_timeout: 10)
      flat.photos.attach(io: file, filename: File.basename(URI.parse(url).path))
    rescue Net::OpenTimeout, OpenURI::HTTPError => e
      puts "⚠️  Skipping image #{url} due to error: #{e.message}"
    end
  end
end

puts "Creating flats..."

flats = [
  {
    title: "Home Sweet Home",
    location: "Villeneuve-la-Garenne, France",
    description: "Enjoy a stylish and central home. Located 15 minutes from Paris via the RER C via Les Gresillons station. This large studio is located in the heart of Villeneuve-la-Garenne and it is right in front of the shopping center Quartz. So you'll appreciate the proximity (20 meters) to various shops for shopping and several restaurants. Free parking is available 7 days a week in the Quartz shopping center in front of my building (20 m). Please note, it closes every night from 11pm to 8am.",
    image_url: [
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762097897/5a795a6d-b762-4326-a165-18372fb60022_lrwvnl.avif",
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762097905/79103e1a-f2b4-4e00-8cf9-84812d35adf2_tsqclj.avif",
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762097901/9c58b945-7bf9-4555-9a98-7fbe1697abb8_xp1u0m.avif",
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762097892/3e682143-0ce4-4046-be0b-12695d2f8d29_ofhmek.avif",
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762097888/02dca171-c54c-4ff6-85bd-1ab1ce5216b4_fkk4ua.avif",
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762097884/1a16fa84-e782-43d0-95d9-3c8f784ec3e3_x4seum.avif",
    ],
  },

  {
    title: "Petite Coquille d'Endoume, Sea View Design Apart",
    location: "Marseille, France",
    description: "Discover the La Petite Coquille d'Endoume, a DESIGN apartment  in the heart of Marseille's chic Endoume district, only 10 minutes walk to the beach! This light filled stylish retreat with little sea views (38 m2/410 sq ft) was renovated in 2024 with great attention to quality & detail.",
    image_url: [
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762097532/b2056fb1-b81a-4321-8a44-1c0c4656337a_zhjmsi.avif",
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762097534/d0e55ed7-5367-4e5d-b753-4fd199950ef2_mgmupb.avif",
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762097538/e9cf6ba5-b064-40f6-9612-ed98f62040c2_dnbbas.avif",
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762097541/e621c5c9-f2e9-4a1f-9032-b65fede35e14_i3mcbp.avif",
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762097545/e859c8f2-6f05-4362-b5ec-d96153a9c976_zxk4ms.avif",
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762097548/fe729a08-2e80-4b00-802a-081f3b5572f8_tdf9z0.avif",
    ],
  },

  {
    title: "Stunning, Dbl En Suite in Grade II Georgian Home",
    location: "London, United Kingdom",
    description: "Built in 1697, our lovely Georgian Home is right next to Putney Bridge. Located on the first floor, a modern and contemporary room perfect for couples and the single traveller.",
    image_url: [
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762097026/12b13939-c5cf-4dcb-93c8-620c9d941dd5_i4jffo.avif",
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762097024/2ff1a91f-99bb-4eb0-8b22-4e943992d1b6_mirtfv.webp",
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762097031/098299f8-bd86-4af2-b3a1-5e9e0525e4c3_adrgow.avif",
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762097033/bacc9f7b-2f83-4668-b603-54c61d162993_i44xpl.avif",
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762097036/dd39e919-8ab6-42d8-aa88-9d679f0fb5fe_by1a7g.avif",
    ],
  },

  {
    title: "City Centre Location - Unique Romantic Canal Boat",
    location: "Greater Manchester, United Kingdom",
    description: "An adorable pet-friendly, romantic hideaway in heart of Manchester. Quirky interior inspired by 1950’s Havana. Showpiece is an honesty bar with wine, spirits & cigars. Kitchen equipped for cooking with some light breakfast provided ",
    image_url: [
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762097430/2209b757-a47d-4e04-9383-fa1df3354bd7_qp84t2.avif",
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762097442/f0e21de9-3905-44d5-8fe7-06910bdb2a15_ha49yi.avif",
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762097439/d1ef94f7-65bd-448c-ad14-1674e8e0788d_y6jbjv.avif",
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762097436/c27e7a53-c9bb-4673-8139-66d7fa60db34_lr8vu5.avif",
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762097433/76869763-21ea-43a7-8036-3f4f451f53b3_u6fvrf.avif",
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762097427/34dad06a-bcf5-4a05-b1bb-3c6a350e98b9_ux6rln.webp",
    ],
  },

  {
    title: "2 Bedrooms Apartment in Barcelona",
    location: "Barcelona, Spain",
    description: "Stylish apartment on a semi-pedestrian street in the iconic Gracia neighborhood, 800 meters from Sagrada Familia and Hospital de Sant Pau, and a 20-minute walk to Parc Güell or Passeig de Gracia. Comfortable, quiet, and elegant, the apartment is fully renovated. It features a queen-size bed, high-quality linens and towels, AC, kitchen, and sofa bed. Enjoy 2 SmartTVs (Netflix, HBO...) and high-speed Wi-Fi. This cozy apartment offers access to a beautiful, dynamic neighborhood from a serene street",
    image_url: [
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762096844/f9c633db-6e4a-4553-bef1-25180beea4d2_ts9swr.avif",
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762096842/e943177e-e718-45c2-bd94-2e64178d7ba2_dhqbth.avif",
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762096840/a2c1ae6d-8db1-4238-a6cf-63f5a66a06bd_puhuls.avif",
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762096839/8418d289-8aaa-4bba-8551-d3f7e9a4599f_q6uskg.avif",
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762096838/4e7d5bd0-5b45-4035-8860-f6983fcc47dd_bztuun.avif",
    ],
  },

  {
    title: "Plaza España Skyline Standard",
    location: "Madrid, Spain",
    description: "The apartment Standar is a stay cozy, bright and quiet of 47 square meters, with air conditioning, with external orientation to a quiet street. The apartment is decorated in modern style.",
    image_url: [
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762097312/fca7fa55-d483-4331-8217-f55329872649_mraz25.avif",
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762097309/cbfa54b1-9c8b-4755-9dd5-a465ebe77802_j5oavm.avif",
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762097306/8464ead1-67b7-48c9-8219-6e7a918f7c42_tq0czb.avif",
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762097303/359e8ad0-c255-4ec5-bd8f-4c6aba4f0b64_dwe9uz.avif",
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762097300/8cfd2279-3a86-43fe-aed3-b7b60724368f_lulazj.avif",
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762097297/7e8063f6-b155-43b1-b687-b4f14a6f787c_puppap.avif",
    ],
  },

  {
    title: "Hygge House Downtown",
    location:  "Lisbon, Portugal",
    description: "Welcome to Hygge House Downtown—where Scandinavian comfort meets Lisbon’s historic charm. Located on Rua de São Julião 48, just a stone's throw from the iconic Praça do Comércio, our luxurious apartments offer an exquisite blend of modern elegance and warm coziness. Perfect for both short and extended stays, Hygge House Downtown is your ideal urban retreat in Lisbon.",
    image_url: [
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762096931/5aa4edba-e4fd-4fa8-a5a3-4f39108ed3a1_wekrfz.avif",
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762096933/6c20e257-16ad-4ceb-a398-04aa76ae765e_go4gco.avif",
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762096935/8eb56422-4476-4e98-af08-7274395dba08_mss2gq.avif",
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762096937/d8ca57fc-b78f-4d03-824f-00db6b7e5e95_onpjze.avif",
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762096939/d72d01e9-8ad4-4356-bca6-0ef50899cff5_uzikj3.avif",
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762096941/e93f84c5-6184-4b5f-8125-5cb179c42129_cq9csw.avif",
    ],
  },

  {
    title: "PinPorto Downtown II",
    location: "Porto, Portugal",
    description: "This PinPorto flat has a perfect location for those who want to stay in the heart of the city. This premium flat is placed as downtown as you can get, in a quite street just by the City Hall and its best attractions.",
    image_url: [
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762098030/8c5964ae-6291-4279-9933-930117ecc747_n4tjng.avif",
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762098035/56e8958c-4681-4afa-aea3-7c3b128ecbc4_tdxdhe.avif",
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762098026/4e1ce728-8cfd-40ae-a1b2-cca3e288f672_r1odwk.avif",
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762098039/911e29e1-7482-4ac5-a26e-4f35ff3dd5da_cffcuj.avif",
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762098044/992b45d1-d6e6-4aa8-967d-0f504c062b54_m4fwre.avif",
    ],
  },

  {
    title: "Design Flat with Mezzanine – Stunning Village View",
    location: "Zermatt, Switzerland",
    description: "Renovated mezzanine apartment combining space, light and alpine charm—just 5 minutes from central Zermatt.
Enjoy village views, high ceilings, 2 bedrooms, 2 bathrooms, a bright living area and a fully equipped kitchen.
Ideal for couples, families or skiers seeking both comfort and calm.",
    image_url: [
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762098337/aabbe2ea-8906-46b4-8bd6-76a7fcf3a435_czo2c8.avif",
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762098326/09af99ba-9b34-4761-bf5f-46fe50ee8d6d_pmvzzf.avif",
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762098331/73d49ee1-10df-4d76-b6b9-33826c7b0af1_ul9b8h.avif",
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762098347/d1808c7f-f3f0-4434-a6d8-e4cfd0bf3aff_mxfzhh.avif",
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762098342/d74c2ac0-7572-4dc6-9cb2-6df460462217_yfgv9h.avif",
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762098353/dd018090-72ef-4f93-bcbb-7063a09d5bed_ogphts.avif",
    ],
  },

  {
    title: "Waterfront Cabin - 15 Minutes from Downtown Oslo",
    location: "Nordstrand, Norway",
    description: "Waterfront Cabin – Just 15 Minutes from Downtown Oslo! 🏡🌿🌊

Escape the city and unwind in our charming traditional Norwegian cabin, perfectly nestled by the water yet only 15 minutes from downtown Oslo. Enjoy the tranquility of nature, breathtaking sunsets, and the soothing sounds of the waves – an ideal retreat for relaxation.",
    image_url: [
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762097775/4d3702ff-15ec-4525-851e-2f347186ec97_y5quyc.avif",
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762097787/3690ea54-63da-4fe0-99f2-a9374c2c734e_ryxkab.avif",
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762097791/a89fa7ca-803a-46af-a4fa-958423385a83_odbyjg.avif",
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762097783/993c68a9-71f0-4f4c-95ee-3f9ef11f25e9_sfause.avif",
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762097779/105a025c-d037-4d64-9976-3295eb96f3cf_imhjz7.avif",
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762097771/1fbb14fa-5243-4283-a6c5-395f85144079_jagu3c.avif",
    ],
  },

  {
    title: "Lux 2-story apt w/ terrace in best part of town",
    location: "Stockholms kommun, Sweden",
    description: "Experience luxury living in this recently built, 2-story townhouse with a private terrace overlooking a quiet garden. ",
    image_url: [
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762098154/33eec2a4-695e-442f-9cda-ae6997ecb410_gomoko.avif",
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762098145/3ea7c5c3-7eae-40aa-82d4-aa07f0690cbd_oxzetp.avif",
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762098140/3b40b5cb-32e0-40fd-bd6a-8260e293a3d8_iytjpe.avif",
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762098150/8b68b3f5-6dd7-48fa-91e1-a033c8d6f7b5_vpfi1i.avif",
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762098135/3a1d6916-d628-434a-8680-4fec1ed58934_pghj4b.avif",
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762098158/84b1fe4b-2660-4f02-9e01-f1dba87a5692_jgjnap.avif",
    ],
  },

  {
    title: "Secret Garden Studio, private suite!",
    location: "Amsterdam, Netherlands",
    description: "To ultimate relaxation in a city where there is always something to do?
In Amsterdam North, in the circular district of Buiksloterham, the new “place to be” of Amsterdam, you will find the studio, an oasis of peace for the visitors of bustling Amsterdam.
The bright studio has a private entrance and is located on a small “Japanese” courtyard garden. When you open the sliding door, you are in the garden.
In the cozy quiet room there is a queen-sized bed. The bathroom en suite is also located in the courtyard garden.",
    image_url: [
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762096565/3a4938d8-e769-4f67-9cf5-b24bb39915dd_sadjzw.avif",
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762096568/f8e388ae-bcc0-4d7c-ba7a-016ea684225e_rkgxpw.webp",
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762096567/ba806232-7913-4514-8ff1-41a7ad7eb3f6_xo6zvn.avif",
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762096566/7190c1e2-9c82-4c73-afa9-4a681a930fdf_hun5iy.avif",
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762096565/5407cdf8-49c4-493a-8ed7-2f0b9155c2ea_ergmjf.avif",
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762096565/4b278898-aed4-4800-b1be-65aa8cdc9562_z2rims.avif",
    ],
  },

  {
    title: "Zonnig appartement met prachtig uitzicht!",
    location: "Antwerp, Belgium",
    description: "This spacious apartment is modern and colourfully decorated. It features a fully equipped kitchen, a washer and dryer, a living room with a large sofa and dining table, comfortable bedrooms, and a modern bathroom.",
    image_url: [
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762096734/06de84b4-8b5c-4234-836f-2883f2dc5a9c_w6b00c.avif",
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762096732/2add5c20-6a24-4b8e-9417-8aadd0ca0060_vxglme.avif",
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762096735/9bf6f22a-53a4-4330-917c-2f3502db5a6d_xuqig1.avif",
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762096736/62c68ae6-83af-40b4-a4f9-4bbd23e0dccb_s4kect.avif",
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762096738/a4b585d1-be52-4872-8c8b-a3d3e8fcee53_duowsu.avif",
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762096739/ef95d77a-a144-4759-980d-275224d3c759_frmxl9.avif",
    ],
  },

  {
    title: "Sleeping in the greenhouse with great views",
    location: "Horw, Switzerland",
    description: "Enjoy the sounds of nature when you stay in this unique place.
Sleeping in the greenhouse means being very close to the plants, a good bed awaits you and a warm stove lets you comfortably enjoy the time you spend with us.",
    image_url: [
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762097194/Lucern_1_vhyelt.avif",
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762097197/Lucern_2_ehliwt.avif",
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762097199/Lucern_3_amapep.avif",
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762097202/Lucern_4_s3o0yk.avif",
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762097204/Lucern_5_or8tju.avif",
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762097207/Lucern_6_frvfem.avif",
    ],
  },
      
  {
    title: "Numa | Design Studio in Downtown Munich",
    location: "Munich, Germany",
    description: "This comfortable room offers 18 m² of space for up to 2 people. The double bed (160x200) and the modern bathroom with shower make this accommodation the perfect starting point to experience Munich. There is also a kitchenette with sustainable coffee, a kettle and a mini fridge. You'll have everything you need for maximum comfort and minimum stress.",
    image_url: [
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762097665/253855ff-2d65-47dc-b178-e5af09616bb4_cwf0hn.avif",
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762097654/3e015e36-444e-455a-9ed9-0efa0813b671_yledus.avif",
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762097657/5e795e9c-5ed7-4994-a0aa-60979efe1848_v1ub3q.avif",
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762097646/2b1c2a31-3e2f-4283-b167-a17523ab1bfc_ekvbd3.avif",
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762097650/3a9359e2-486a-4036-80f6-593e6708b59e_baefrz.avif",
      "https://res.cloudinary.com/daadrtkvx/image/upload/v1762097661/7d357b92-795a-4035-91c3-0074bbce7500_pibebo.avif",
    ],
  },
]

flats.each_with_index do |attrs, index|
  user = users[index % users.size]

  flat = Flat.create!(
    title: attrs[:title],
    location: attrs[:location],
    description: attrs[:description],
    user: user
  )

  attach_photos(flat, attrs[:image_url])

  puts "✅ Created '#{flat.title}' for #{user.email} with #{flat.photos.count} photos"
end

puts "🌟 Done seeding #{Flat.count} flats and #{User.count} users!"