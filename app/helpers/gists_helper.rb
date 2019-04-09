module GistsHelper

  def cut_body(gist)
    truncate(gist.question.body, length: 26, separator: ' ')
  end
end
