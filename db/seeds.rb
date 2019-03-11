# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

categories_titles = %w[Птицы Рыбы Грибы]

tests_titles = [
                [1, 'Аист', 1],
                [2, 'Скат', 1],
                [3, 'Шампиньон', 0],
                [2, 'Мурена', 0],
                [1, 'Зимородок', 2]]

questions_bodies = [
                    [2,'Назовите самый большой вид Скатов?'],
                    [3, 'Знали ли вы, что Шампиньон является самым популярным культивируемым грибом в мире?'],
                    [4, 'А вы знали что Мурены могут достигать длины 3 метров?'],
                    [1, 'Какова продолжительность жизни Белого аиста?'],
                    [5, 'Назовите ареалы обитания Зимородков?']]

answers_bodies = ['Манта или гигантский морской дьявол',
                 'Да',
                 'Да',
                 'Средняя продолжительность жизни 20 лет',
                 'Евразии, в северо-западной части Африки, в Новой Зеландии, Индонезии, Новая Гвинея и Соломоновые острова']


users_names =  %w[Owner, Rick, Interviewed]

users = users_names.map do |name|
  User.create(name: name)
end

categories = categories_titles.map do |title|
  Category.create(title: title)
end

tests = tests_titles.map do |id, title, level|
  Test.create(title: title, level: level, category_id: categories[id].id)
end

questions = questions_bodies.map do |id, body|
  Question.create(body: body, test_id: tests[id].id)
end

answers = answers_bodies.map.with_index(1) do |body, id|
  Answer.create(body: body, question_id: questions[id].id)
end
