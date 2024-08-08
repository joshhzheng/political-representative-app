# frozen_string_literal: true

class MyNewsItemsController < SessionController
  before_action :set_representative
  before_action :set_representatives_list
  before_action :set_news_item, only: %i[edit update destroy]
  before_action :set_issue, only: %i[search_top_articles]

  def new
    @news_item = NewsItem.new
  end

  # Adding this: This is the action that will render the select issue view when a user presses "Add New Article"
  def select_issue; end

  def create
    @news_item = NewsItem.new(news_item_params)
    if @news_item.save
      redirect_to representative_news_item_path(@representative, @news_item),
                  notice: 'News item was successfully created.'
    else
      render :new, error: 'An error occurred when creating the news item.'
    end
  end

  # Adding this, when a user presses "Search" I want this action to set up and call the API and render the search view to show the search results
  def search_top_articles
    @articles = NewsApiService.new.fetch_top_articles(@representative.name, @issue)
    render :search
  end
    
  def update
    if @news_item.update(news_item_params)
      redirect_to representative_news_item_path(@representative, @news_item),
                  notice: 'News item was successfully updated.'
    else
      render :edit, error: 'An error occurred when updating the news item.'
    end
  end

  def destroy
    @news_item.destroy
    redirect_to representative_news_items_path(@representative),
                notice: 'News was successfully destroyed.'
  end

  private

  def set_representative
    @representative = Representative.find(
      params[:representative_id]
    )
  end

  # Adding this to set the issue variable up for controller / views if needed during search results and creation of a new page
  def set_issue
    @issue = Representative.find(
      params[:issue]
    )

  def set_representatives_list
    @representatives_list = Representative.all.map { |r| [r.name, r.id] }
  end

  def set_news_item
    @news_item = NewsItem.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def news_item_params
    params.require(:news_item).permit(:news, :title, :description, :link, :issue, :representative_id)
  end
end
