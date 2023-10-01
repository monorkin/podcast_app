module FeedRequestHelper
  def stub_feed_request_for(url, with:)
    case with
    when Pathname then with = with.read
    when File then with = with.read
    end

    stub_request(:get, url).to_return(
      status: 200,
      body: with,
      headers: { 'Content-Type' => 'application/xml' }
    )
  end
end
