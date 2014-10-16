require 'test_helper'

class ChannelsControllerTest < ActionController::TestCase
  setup do
    @channel = channels(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:channels)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create channel" do
    assert_difference('Channel.count') do
      post :create, channel: { category_id: @channel.category_id, cloud_id: @channel.cloud_id, copyright: @channel.copyright, description: @channel.description, docs: @channel.docs, generator: @channel.generator, image_id: @channel.image_id, language: @channel.language, lastBuildDate: @channel.lastBuildDate, link: @channel.link, managingEditor: @channel.managingEditor, pubDate: @channel.pubDate, skipDays_id: @channel.skipDays_id, skipHours_id: @channel.skipHours_id, textInput: @channel.textInput, title: @channel.title, ttl: @channel.ttl, webMaster: @channel.webMaster }
    end

    assert_redirected_to channel_path(assigns(:channel))
  end

  test "should show channel" do
    get :show, id: @channel
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @channel
    assert_response :success
  end

  test "should update channel" do
    put :update, id: @channel, channel: { category_id: @channel.category_id, cloud_id: @channel.cloud_id, copyright: @channel.copyright, description: @channel.description, docs: @channel.docs, generator: @channel.generator, image_id: @channel.image_id, language: @channel.language, lastBuildDate: @channel.lastBuildDate, link: @channel.link, managingEditor: @channel.managingEditor, pubDate: @channel.pubDate, skipDays_id: @channel.skipDays_id, skipHours_id: @channel.skipHours_id, textInput: @channel.textInput, title: @channel.title, ttl: @channel.ttl, webMaster: @channel.webMaster }
    assert_redirected_to channel_path(assigns(:channel))
  end

  test "should destroy channel" do
    assert_difference('Channel.count', -1) do
      delete :destroy, id: @channel
    end

    assert_redirected_to channels_path
  end
end
