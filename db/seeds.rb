require 'faker'

Retro.delete_all
Note.delete_all

Retro.create(name: "Philly 3 Week 6 Retro")
Retro.create(name: "Boston 18 Week 2 Retro")
Retro.create(name: "Virtual Team Retro 9/8/2017")

30.times do
  Note.create(text: Faker::Hipster.sentence, emotion: Note::EMOTIONS.sample, retro: Retro.all.sample)
end
