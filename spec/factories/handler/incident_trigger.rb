FactoryGirl.define do
  factory :handler_incident_trigger, class: Reveille::Event::Handler::IncidentTrigger do
    event 'incident.triggered'
    association :source, factory: :incident
    association :actor, factory: :user
  end
end