# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
Category.destroy_all
Test.destroy_all
Question.destroy_all
Answer.destroy_all


categories_titles = %w[Птицы Рыбы Грибы]

tests_titles = [
                [0, 'Аист', 1],
                [1, 'Скат', 1],
                [2, 'Шампиньон', 0],
                [1, 'Мурена', 0],
                [0, 'Зимородок', 2]]

questions_bodies = [
                    [1,'Назовите самый большой вид Скатов?'],
                    [2, 'Знали ли вы, что Шампиньон является самым популярным культивируемым грибом в мире?'],
                    [3, 'А вы знали, что Мурены могут достигать длины 3 метров?'],
                    [0, 'Какова продолжительность жизни Белого аиста?'],
                    [4, 'Назовите ареалы обитания Зимородков?']]

answers_bodies = ['Манта или гигантский морской дьявол',
                 'Да',
                 'Да',
                 'Средняя продолжительность жизни 20 лет',
                 'Евразии, в северо-западной части Африки, в Новой Зеландии, Индонезии, Новая Гвинея и Соломоновые острова']

users_names =  %w[Owner, Rick, Interviewed]

users = users_names.map do |name|
  User.create!(name: name)
end

categories = categories_titles.map do |title|
  Category.create!(title: title)
end

tests = tests_titles.map do |index, title, level|
  Test.create!(title: title, level: level, category_id: categories[index].id)
end

questions = questions_bodies.map do |index, body|
  Question.create!(body: body, test_id: tests[index].id)
end

answers = answers_bodies.map.with_index(0) do |body, index|
  Answer.create!(body: body, question_id: questions[index].id)
end


HistoryTest.create!(user_id: users[1].id, test_id: tests[0].id)
HistoryTest.create!(user_id: users[1].id, test_id: tests[2].id)
HistoryTest.create!(user_id: users[1].id, test_id: tests[3].id)
HistoryTest.create!(user_id: users[2].id, test_id: tests[4].id)
