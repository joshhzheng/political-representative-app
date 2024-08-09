# frozen_string_literal: true

class MyNewsItemsController < SessionController
  before_action :set_representative
  before_action :set_representatives_list, :set_issues_list
  before_action :set_news_item, only: %i[update destroy]
  before_action :set_issue, only: %i[search_top_articles]
  before_action :set_ratings, only: %i[search_top_articles]

  def new
    @news_item = NewsItem.new
  end

  def create
    @news_item = NewsItem.create!(news_item_params)
    if @news_item.save
      redirect_to representative_news_item_path(@representative, @news_item),
                  notice: 'News item was successfully created.'
    else
      render :new, error: 'An error occurred when creating the news item.'
    end
  end

  # When a user presses "Search", set up and call the API
  # render the search view to show the search results
  def search_top_articles
    @representative_name = set_name
    @issue = set_issue

    # TODO: change to fetch_top_articles
    # fetch_top_articles most of the time returns an empty list, hence why we're fetching_any_articles
    @top_articles = NewsAPIService.new.fetch_top_articles(@representative_name, @issue)
    render :top5search
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

  # Use this to set up ratings parameter
  def set_ratings
    @ratings = NewsItem.rating_scores
  end

  # Use this to set the name when querying user and they choose different reps
  def set_name
    reps_id = params.dig(:news_item, :representative_id).presence || ' '
    @representative_name = Representative.find_by(id: reps_id)&.name
  end

  # Use this to set the issue variable up for controller / views
  def set_issue
    @issue = params.dig(:news_item, :issue).presence || ' '
  end

  # Use this to set up the list of issues for the view
  def set_issues_list
    @issues = NewsItem.issue_topics
  end

  def set_representative
    @representative = Representative.find(
      params[:representative_id]
    )
  end

  def set_representatives_list
    @representatives_list = Representative.all.map { |r| [r.name, r.id] }
  end

  def set_news_item
    @news_item = NewsItem.find(params[:id])
  end

  def news_item_params
    params.require(:news_item).permit(:news, :title, :description, :link, :issue, :representative_id, :rating)
  end
end
