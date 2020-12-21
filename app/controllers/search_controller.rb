class SearchController < ApplicationController

  def search
    @value = params["search"]["value"] #検索にかけた文字列を代入
    @model = params["search"]["model"] #選択したmodelを代入
    @how = params["search"]["how"] #選択した検索方法を代入
    @data = search_for(@how,@model,@value) #search_forの引数にインスタン変数を定義
  end #dataに最終的な検索結果が入る


  private

  def match(model,value) #def search_forでhowがmatchだった場合の処理
    if model == 'user' #modelがuserの場合の処理
      User.where(name:value) #whereでvalueと完全一致するnameを探す
    elsif model == 'book'
      Book.where(title:value)
    end
  end

  def foward(model,value)
    if model == 'user'
      User.where("name LIKE?", "#{value}%") # ％で曖昧検索を表す
    elsif model == 'book'
      Book.where("title LIKE?", "#{value}%")
    end
  end

  def backward(model,value)
    if model == 'user'
      User.where("name LIKE?", "%#{value}")
    elsif model == 'book'
      Book.where("title LIKE?", "%#{value}")
    end
  end

  def partical(model,value)
    if model == 'user'
      User.where("name LIKE?", "%#{value}%")
    elsif model == 'book'
      Book.where("title LIKE?", "%#{value}%")
    end
  end

  def search_for(how,model,value) #seachアクション内で定義した情報が引数に入る
    case how #検索方法のhowの中身がどれなのかwhenの条件分岐で探す

    when 'match'
      match(model,value) #検索方法の引数に(model,value)を定義。例えばhowがmatchの場合はdef matchの処理にいく
    when 'foward'
      foward(model,value)
    when 'backward'
      backward(model,value)
    when 'partical'
      partical(model, value)
    end
  end
end
