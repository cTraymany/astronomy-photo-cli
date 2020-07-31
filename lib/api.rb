class API

    def self.valid_country?(calling_code)
        url = "https://restcountries.eu/rest/v2/callingcode/#{calling_code}"
        response = HTTParty.get(url, follow_redirects: true)
        response.ok?
        # recode so that if the response is okay, I don't have to make the request
        # again in the below method
    end

    def self.get_country_by_calling_code(calling_code)
        url = "https://restcountries.eu/rest/v2/callingcode/#{calling_code}"
        response = HTTParty.get(url)

        countries_by_code = []

        response.each do |hash|
            country_data = {}
            country_data[:name] = hash["name"],
            country_data[:region] = hash["region"],
            country_data[:population] = hash["population"],
            country_data[:capital] = hash["capital"],
            # country_data[:borders] = hash["borders"],
            # country_data[:languages] = hash["languages"],
            country_data[:flag_link] = hash["flag"]
            countries_by_code << country_data
        end
        countries_by_code
        # code sandwich! change method to map instead of each
    end

    def self.extract_country(calling_code)
        # find a way to do the same thing using #self.get_country_by_calling_code(calling_code)
        countries_by_code = API.get_country_by_calling_code(calling_code)
        countries_by_code.map { |country| country[:name] }
    end
end