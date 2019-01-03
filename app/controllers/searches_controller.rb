class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'R2CQT15XP5IJCUVEQHHXFT2PIQ0JWQ51VC4PFLLWPKGYDRK5'
      req.params['client_secret'] = 'D2GFVPYPJMZFPVPWAE2QKHKVQNSI3HU2A2E1KSZKSABAGRHE'
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = params[:searchterm]


    end
    body = JSON.parse(@resp.body)
    if @resp.success?
      @venues = body["response"]["venues"]
    else
      @error = body['meta']['errorDetail']
    end
    render 'search'
  end
end
