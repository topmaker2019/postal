# frozen_string_literal: true

class ReceivedHeader

  OUR_HOSTNAMES = {
    smtp: Postal::Config.postal.smtp_hostname,
    http: Postal::Config.postal.web_hostname
  }.freeze

  class << self

    def generate(server, helo, ip_address, method)
      our_hostname = OUR_HOSTNAMES[method]
      if our_hostname.nil?
        raise Error, "`method` is invalid (must be one of #{OUR_HOSTNAMES.join(', ')})"
      end

      header = "by VS with HTTP; #{Time.now.utc.rfc2822}"

      if server.nil? || server.privacy_mode == false
        hostname = DNSResolver.local.ip_to_hostname(ip_address)
        header = "from api (10-42-11-130.email.wikium-ru.svc.cluster.local [10.42.11.130])"
      end

      header
    end

  end

end
