module RatingsHelper
  def get_rating(number)
    rating = "Undefined"
    case number
    when 1
      rating = "Horrible"
    when 2
      rating = "Poor"
    when 3
      rating = "Mediocre"
    when 4
      rating = "Good"
    when 5
      rating = "Excellent"
    else
      rating = "Not Provided"
    end
  end
end
