# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
models = %w(User Category Test Question Answer HistoryTest)
models.each{|model| model.constantize.destroy_all}
# models.each do |model|
#   ActiveRecord::Base.connection.execute("DELETE from sqlite_sequence where name = \'#{model.constantize.table_name}\'")
# end

categories_titles = %w[Птицы Рыбы Грибы]

tests_titles = [
                [0, 'Аист', 1],
                [1, 'Скат', 2],
                [2, 'Шампиньон', 0],
                [1, 'Мурена', 0],
                [0, 'Зимородок', 3]]

questions_bodies = [
                    [1,'Назовите самый большой вид Скатов?'],
                    [2, 'Знали ли вы, что Шампиньон является самым популярным культивируемым грибом в мире?'],
                    [3, 'А вы знали, что Мурены могут достигать длины 3 метров?'],
                    [0, 'Какова продолжительность жизни Белого аиста?'],
                    [4, 'Назовите ареалы обитания Зимородков?']]

answers_bodies = [
                  {'Манта или морской дьявол': true,
                   'Орляковые скаты': false,
                   'Крылатые орляки': false},
                  {'Да': true,
                   'Нет': false},
                  {'Да': true,
                   'Нет': false},
                  {'Средняя продолжительность жизни 20 лет': true,
                   'Средняя продолжительность жизни 30 лет': false},
                  {'Евразии, в северо-западной части Африки, в Новой Зеландии, Индонезии, Новая Гвинея и Соломоновые острова': true,
                   'Северо-западная часть Канады и Аляска': false}]


users_names =  %w[Owner Rick Interviewed]

users = users_names.map do |name|
  user = User.create!(name: name, email: "#{name}@example.edu", password: "#{name}@example.edu", confirmed_at: Time.now)
end

categories = categories_titles.map do |title|
  Category.create!(title: title)
end

tests = tests_titles.map do |index, title, level|
  Test.create!(title: title, level: level, category_id: categories[index].id, author_id: users[0].id)
end

questions = questions_bodies.map do |index, body|
  Question.create!(body: body, test_id: tests[index].id)
end

answers_bodies.each.with_index(0) do |answers, index|
    answers.each do |body, correct|
      Answer.create!(body: body, correct: correct, question_id: questions[index].id)
    end
end


# HistoryTest.create!(user_id: users[1].id, test_id: tests[0].id)
# HistoryTest.create!(user_id: users[1].id, test_id: tests[2].id)
# HistoryTest.create!(user_id: users[1].id, test_id: tests[3].id)
# HistoryTest.create!(user_id: users[2].id, test_id: tests[4].id)
