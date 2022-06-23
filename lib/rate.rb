# Определяем класс
class Rate
  # Определяем конструктор класса
  def initialize(array_info)
    # Наполняем данными наш объект
    @name = array_info.elements["Name"].text
    @code = array_info.elements["CharCode"].text
    @scale = array_info.elements["Scale"].text
    @rate = array_info.elements["Rate"].text
  end

  # Определяем метод для отображения информации об объекте
  def show_rate
    puts "#{@scale} #{@name}(#{@code}): #{@rate} белорусских рублей."
  end

end