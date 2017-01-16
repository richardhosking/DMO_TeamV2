json.array!(@assessments) do |assessment|
  json.extract! assessment, :id, :pulse, :, :resps, :, :sats, :, :temp, :, :weight, :, :hb, :, :gluc, :, :systolic, :, :diastolic, :
  json.url assessment_url(assessment, format: :json)
end
