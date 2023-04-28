FactoryBot.define do
  factory :label do
    lbl_name { "ラベル１" }
  end

  factory :second_label, class: Label do
    lbl_name { "ラベル２" }
  end

  factory :third_label, class: Label do
    lbl_name { "ラベル３" }
  end
end
