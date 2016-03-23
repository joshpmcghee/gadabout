require 'uri'
require 'rest-client'
require 'json'

module Gadabout
  class Client

    API_VERSION = "v1"

    def initialize(host="localhost", port=4647)
      @rest = RestClient::Resource.new(URI::HTTPS.build({:host => host, :port => port, :path => API_VERSION}))

    end

    #GET /v1/jobs
    def jobs(opts={})
      # Validate options
      supported_opts = ["prefix"]
      raise "Invalid options. Supported: #{supported_options}" unless options.keys.reject{ |k| supported_opts.include? k }.empty?

      path = "/jobs"

      begin
        resp = @rest[path].get opts
      rescue e => StandardError
        raise "Error whilst making HTTP request to the Nomad Agent: #{e}"
      end

      return JSON.parse(resp)
    end

    #GET /v1/job
    def job(id)

      path = URI.join("/job", id)

      begin
        resp = @rest[path].get
      rescue e => StandardError
        raise "Error whilst making HTTP request to the Nomad Agent: #{e}"
      end

      return JSON.parse(resp)
    end

    #PUT/POST /v1/job
    def force_job_evaluation(id)
    end

    #PUT/POST /v1/job
    def force_periodic_job(id)
    end

    #PUT/POST /v1/job
    def register_job(spec)
    end

    #DELETE /v1/job
    def delete_job(id)
    end

    #GET /v1/nodes
    def nodes
    end

    #GET /v1/node
    def node
    end

    #PUT/POST /v1/node
    def create_evaluation
    end

    #GET /v1/allocations
    def allocations
    end

    #GET /v1/allocation
    def allocation
    end

    #GET /v1/evaluations
    def evaluations
    end

    #GET /v1/evaluation
    def evaluation
    end

    #GET /v1/agent/self
    def agent_info
    end

    #PUT/POST /v1/agent/join
    def agent_join
    end

    #GET /v1/agent/members
    def members
    end

    #PUT/POST /v1/agent/force-leave
    def force_leave
    end

    #GET /v1/agent/servers
    def servers
    end

    #PUT/POST /v1/agent/servers
    def update_servers
    end

    #GET /v1/client/fs/ls
    def client_ls
    end

    #GET /v1/client/fs/cat
    def client_cat
    end

    #GET /v1/client/fs/stat
    def client_stat
    end

    private
  end
end
