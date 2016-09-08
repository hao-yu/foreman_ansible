module ProxyAPI
  # ProxyAPI for Ansible
  class Ansible < ::ProxyAPI::Resource
    def initialize(args)
      @url = args[:url] + '/ansible/'
      super args
    end

    PROXY_ERRORS = [
      Errno::ECONNREFUSED,
      SocketError,
      Timeout::Error,
      Errno::EINVAL,
      Errno::ECONNRESET,
      EOFError,
      Net::HTTPBadResponse,
      Net::HTTPHeaderSyntaxError,
      Net::ProtocolError,
      RestClient::ResourceNotFound
    ].freeze

    def roles
      parse(get('roles'))
    rescue *PROXY_ERRORS => e
      raise ProxyException.new(url, e, N_('Unable to get roles from Ansible'))
    end
  end
end