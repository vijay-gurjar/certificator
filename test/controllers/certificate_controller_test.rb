require "test_helper"

class CertificateControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get certificate_index_url
    assert_response :success
  end

  test "should get download" do
    get certificate_download_url
    assert_response :success
  end
end
