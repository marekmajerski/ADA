# rubocop:disable all
# Namespace for PageObject
class PageObject
  # Class that creates valid random contract jsons to be sent to media manager
  class ContractJsonCreator
    # The possible age values for a contract
    AGES = %w( 18-24 35-34 35-44 45-54 55+ )
    # The possible agencies for a contract
    AGENCIES = %w(
      Initiative Doremus MEC Moxie R&R\ Partners, Dedicated\ Media Razorfish Windowseat
      Mandala\ Agency Allscope\ Direct Ogilvy Simon\ and\ Schuster Weber\ Shandwick Centro
      Ignited Media\ Kitchen Godfrey\ Q PHD Maxus\
    )
    # The possible brands for a contract
    BRANDS = %w(
      Toshiba Corning\ Gorilla\ Glass Hot\ Tub\ Time\ Machine Fox\ TH\ Taken\ 3
      Nespresso AT&T Shout Western\ Digital\ -\ My\ Cloud\ US Nike 18|8\ Fine\ Men\'s\ Salon
      Mountain\ Khakis Life\ Alert Purina SAGE Graces\ Guide Orsam\ Sylvania Tenet\
    )
    # The possible geo values for a contract
    GEOS = %w(US\ -\ $150,000 UK\ -\  $12,500 FR\ -\ $8,000 DE\ -\ $8,000 JP\ -\ $7,500)
    # The possible regions for a contract
    REGIONS = %w( na emea apac )
    # The possible networks for a contract
    NETWORKS = %w( InStream InDisplay InSearch )
    # The possible genders for a contract
    GENDERS = %w( Male Female Unknown )
    # The possible currencies for a contract
    CURRENCIES = %w(AUD CAD EUR GBP PLN SGD USD)
    # The possible adwords account names for a contract
    ADWORDS_ACCOUNT_NAMES = %w(
      494-211-5363
    )
    # The possible video length values
    VIDEO_LENGTHS = %w(:30\ sec :60\ sec :90\ sec)
    # The possible kpis for a contract
    KPIS = %w(CPA\ and\ qualified shopping.\ CPV\ is\ important but\ they\ more\ want\ to\ reach)
    # The possible targetings for a contract
    TARGETING = 'Attached, please notice how each plan goes with each respective commercial and'

    # @param excluded_ids [Array] an array of strike ids that will not appear as a generated
    #   strike_project_id for the created json
    def initialize(excluded_ids: [])
      @excluded_ids = excluded_ids
    end

    # rubocop:disable Metrics/MethodLength
    # rubocop:disable Metrics/AbcSize

    # @param kwargs [Symbol, Symbol, ..]
    # @return [Hash] a hash with all the needed values to create a contract json
    def create(**kwargs)
      @kwargs = kwargs
      contract_attrs = {
        customer_id: customer_id,
        salesforce_id: salesforce_id,
        adwords_account_name: adwords_account_name,
        age: age,
        agency: agency,
        billing_profile: kwargs[:billing_profile] || billing_profile,
        brand: brand,
        click_through_url: click_through_url,
        client_service_email: client_service_email,
        client_spend: client_spend,
        companion_banner: companion_banner,
        cpv: cpv,
        currency_c: currency_c,
        cta_overlay_text: cta_overlay_text,
        cta_overlay: cta_overlay,
        end_date: end_date,
        gender: gender,
        geo: geo,
        kpi: kpi,
        margin: margin,
        media_order: media_order,
        more_info: more_info,
        name: name,
        network: network,
        payment_plan: payment_plan,
        region: region,
        sales_rep: sales_rep,
        start_date: start_date,
        strike_project_id: strike_project_id,
        tags: tags,
        targeting: kwargs[:targeting] || targeting,
        view_order: view_order,
        youtube_urls: youtube_urls
      }

      { contracts: [contract_attrs] }
    end


    private

    attr_reader :kwargs

    # @return [String]
    def customer_id
      @customer_id ||= kwargs[:customer_id] || Faker::Number.number(5).to_s
    end

    # @return [String]
    def salesforce_id
      @salesforce_id ||= kwargs[:salesforce_id] || Faker::Number.number(10).to_s
    end

    # @return [String]
    def adwords_account_name
      @adwords_account_name ||= kwargs[:adwords_account_name] || ADWORDS_ACCOUNT_NAMES.sample
    end

    # @return [Array<String>]
    def age
      @age ||= kwargs[:age] ? kwargs[:age].split(' ') : AGES.sample(rand(1..AGES.length))
    end

    # @return [String]
    def agency
      @agency ||= kwargs[:agency] || AGENCIES.sample
    end

    # @return [String]
    def billing_profile
      @billing_profile ||= kwargs[:billing_profile] || 'TBD'
    end

    # @return [String]
    def brand
      @brand ||= kwargs[:brand] || BRANDS.sample
    end

    # @return [Array<String>]
    def click_through_url
      @click_through_url ||=
        if kwargs[:click_through_url]
          kwargs[:click_through_url].split(' ')
        else
          rand(1..3).times.with_object([]) { |_i, res| res << FFaker::Internet.http_url + '?q=ab' }
        end
    end

    # @return [String]
    def client_service_email
      @client_service_email ||= kwargs[:client_service_email] || FFaker::Internet.safe_email
    end

    # @return [Float]
    def client_spend
      @client_spend ||=
        if kwargs[:client_spend]
          kwargs[:client_spend].to_f
        else
          rand(10_000..500_000).round(2)
        end
    end

    # @return [Boolean]
    def companion_banner
      @companion_banner ||= kwargs[:companion_banner] || [true, false].sample
    end

    # @return [Float]
    def cpv
      @cpv ||= kwargs[:cpv] || rand(0.05..0.1).round(2)
    end

    # @return [String]
    def currency_c
      @currency_c ||= kwargs[:currency_c] || CURRENCIES.sample
    end

    # @return [String]
    def cta_overlay_text
      @cta_overlay_text ||= kwargs[:cta_overlay_text] || Faker::Lorem.sentence(1)
    end

    # @return [Boolean]
    def cta_overlay
      @cta_overlay ||= kwargs[:cta_overlay] || 'true'
    end

    # @return [Date]
    def end_date
      @end_date ||= kwargs[:end_date] || Faker::Date.between(Date.today + 15, Date.today + 70)
    end

    # @return [String]
    def gender
      @gender ||= kwargs[:gender] ? kwargs[:gender].split(' ') : GENDERS.sample(rand(1..GENDERS.length))
    end

    # @return [Array<String>]
    def geo
      @geo ||= kwargs[:geo] ? kwargs[:geo].split(' ') : GEOS.sample(rand(1..GEOS.length))
    end

    # @return [Array<String>]
    def video_length
      @video_length ||= kwargs[:video_length] ? kwargs[:video_length].split(' ') : VIDEO_LENGTHS.sample(rand(1..VIDEO_LENGTHS.length))
    end

    # @return [String]
    def kpi
      @kpi ||= kwargs[:kpi] || KPIS.sample
    end

    # @return [Float]
    def margin
      @margin ||= kwargs[:margin] || rand(0.15..0.35).round(2)
    end

    # @return [Float]
    def media_order
      @media_order ||= kwargs[:media_order] || Faker::Number.number(9).to_f.round(2)
    end

    # @return [String]
    def more_info
      @more_info ||= kwargs[:more_info] || FFaker::HipsterIpsum.phrase
    end

    # @return [String]
    def name
      @name ||= kwargs[:name] || FFaker::Company.name
      @name.delete('-')
    end

    # @return [Array<String>]
    def network
      @network ||= kwargs[:network] ? kwargs[:network].split(' ') : NETWORKS.sample(rand(1..3))
    end

    # @return [Array<Hash>]
    def payment_plan
      @payment_plan ||=
        if kwargs[:payment_plan]
          if kwargs[:payment_plan].eql? 'months'
            parts = (Date.parse(start_date)..Date.parse(end_date)).group_by(&:month).map { |_, v| v.first.end_of_month.to_s }
          elsif kwargs[:payment_plan].eql? 'weeks'
            parts = (Date.parse(start_date)..Date.parse(end_date)).select(&:sunday?).map(&:to_s)
          end
          number_of_projects = parts.length - 1
          number_of_projects.times.with_object([]) do |i, res|
            start_date = i
            end_date = i+1
            res << {
              'client_spend': (client_spend / number_of_projects).round(2),
              'start_date': parts[start_date],
              'end_date': parts[end_date],
              'salesforce_id': strike_project_id + i.to_s,
              'project_id': strike_project_id
            }
            i += 1
          end
        else
          begin
            number_of_projects = rand(1..1)
            number_of_projects.times.with_object([]) do |_i, res|
              res << {
                'client_spend': (client_spend / number_of_projects).round(2),
                'end_date': end_date,
                'start_date': start_date,
                'salesforce_id': rand.to_s,
                'project_id': strike_project_id
              }
            end
          end
        end
    end

    # @return [String]
    def region
      @region ||= kwargs[:region] || REGIONS.sample
    end

    # @return [String]
    def sales_rep
      @sales_rep ||= kwargs[:sales_rep] || FFaker::Internet.safe_email
    end

    # @return [Date]
    def start_date
      @start_date ||= kwargs[:start_date] || Faker::Date.between(Date.today + 2, Date.today + 14)
    end

    # @return [String]
    def strike_project_id
      @strike_project_id ||= kwargs[:strike_project_id] ||
        begin
          id = generate_strike_id
          id = generate_strike_id while @excluded_ids.include?(id)
          id
        end
    end

    # @return [String]
    def generate_strike_id
      ::Faker::StrikeId.TV
    end

    # @return [Boolean]
    def tags
      kwargs[:tags] || [true, false].sample
    end

    # @return [String]
    def targeting
      @targeting ||= kwargs[:targeting] || TARGETING
    end

    # @return [Integer]
    def view_order
      @view_order ||= kwargs[:view_order] || Faker::Number.number(9).to_i
    end


    # @return [Array<String>]
    def youtube_urls
      @youtube_urls ||=
        if kwargs[:youtube_urls]
          if kwargs[:youtube_urls].eql? 'placeholder'
            rand(1..5).times.with_object([]) do |i, res|
              res << {
                  youtube_url: '',
                  click_through_url: click_through_url[i],
                  "salesforce_id": rand.to_s,
                  "name": "PH_#{i}",
                  "is_placeholder": true
              }
            end
          else
            youtube_list = kwargs[:youtube_urls].split(' ')
            youtube_list.each_with_index.map do |el, i|
              {
                youtube_url: el,
                click_through_url: click_through_url[i],
                "salesforce_id": rand.to_s,
                "name": "#{el}",
                "is_placeholder": false
              }
            end
          end
        else
          rand(2..5).times.with_object([]) do |i, res|
            res << {
                youtube_url: "https://youtu.be/watch?v=#{Faker::Lorem.word}",
                click_through_url: click_through_url[i],
                "salesforce_id": rand.to_s,
                "name": "URL#{i}",
                "is_placeholder": false
            }
          end
        end
    end
  end
end
# rubocop:enable all
