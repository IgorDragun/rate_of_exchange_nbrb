# Подключаем необходимые либы
require 'net/http' # для загрузки данных по HTTP
require 'uri' # для работы с адресами URI
require 'rexml/document' # для парсинга xml-файлов
require 'cgi' # для раскодирования данных с сайта погоды (город)
require 'date' # для работы с датами

# Подключаем необходимые классы
require_relative 'lib/rate'

# Запрашиваем дату у пользователя в удобном для него формате
puts "Укажите дату, на которую Вы бы хотели получить курсы валют НБРБ"
puts "(дату необходимо указать в формате ДД.ММ.ГГГГ, например 01.06.2022):"
input = nil

while input == nil
  input = STDIN.gets.chomp
end

# Парсим введенную пользователем дату для вставки в URL
begin
  date = Date.parse(input).strftime("%m/%d/%Y").to_s
rescue
  abort "Дата указана неверно. Попробуйте еше раз."
end

# Фиксируем наш URL
url = "https://www.nbrb.by/services/xmlexrates.aspx?ondate=#{date}"

# Отправляем запрос
rates_info = Net::HTTP.get_response(URI.parse(url))

# Парсим полученные данные
doc = REXML::Document.new(rates_info.body)

# Определим время запроса
time_request = Time.now

# Достаем все элементы с курсами
rates_nodes = doc.elements["DailyExRates"].elements.to_a

# Выводим информацию
puts "Время запроса курсов валют: #{time_request}."
puts
rates_nodes.each do |element|
  rate = Rate.new(element)
  rate.show_rate
end