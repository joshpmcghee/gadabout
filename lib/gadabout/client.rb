require 'uri'
require 'rest-client'
require 'json'

module Gadabout

  API_VERSION = "/v1"

  class Client

    def initialize(host="localhost", port=4646)
      @rest = RestClient::Resource.new(URI::HTTP.build({:host => host, :port => port, :path => API_VERSION}))
    end

    #GET /v1/jobs
    def jobs(opts={})
      # Validate options
      supported_opts = ["prefix"]
      raise "Invalid options. Supported: #{supported_opts}" unless opts.keys.reject{ |k| supported_opts.include? k }.empty?

      path = "/jobs"

      begin
        resp = @rest[path].get(:params => opts)
      rescue StandardError => e
        raise "Error whilst making HTTP request to the Nomad Agent: #{e}"
      end

      return JSON.parse(resp)
    end

    #GET /v1/job
    def job(id)
      path = File.join("/job", id)

      begin
        resp = @rest[path].get
      rescue StandardError => e
        raise "Error whilst making HTTP request to the Nomad Agent: #{e}"
      end

      return JSON.parse(resp)
    end

    #GET /v1/job/<ID>/evaluations
    def job_evaluatons(id)
      path = File.join("/job", id, "/evaluations")

      begin
        resp = @rest[path].get
      rescue StandardError => e
        raise "Error whilst making HTTP request to the Nomad Agent: #{e}"
      end

      return JSON.parse(resp)
    end

    #GET /v1/job/<ID>/allocations
    def job_allocations(id)
      path = File.join("/job", id, "/allocations")

      begin
        resp = @rest[path].get
      rescue StandardError => e
        raise "Error whilst making HTTP request to the Nomad Agent: #{e}"
      end

      return JSON.parse(resp)
    end

    #PUT/POST /v1/job
    def force_job_evaluation(id)
      path = File.join("/job", id, "/evaluate")

      begin
        resp = @rest[path].put
      rescue StandardError => e
        raise "Error whilst making HTTP request to the Nomad Agent: #{e}"
      end

      return JSON.parse(resp)
    end

    #PUT/POST /v1/job
    def force_periodic_job(id)
      path = File.join("/job", id, "/periodic/force")

      begin
        resp = @rest[path].put
      rescue StandardError => e
        raise "Error whilst making HTTP request to the Nomad Agent: #{e}"
      end

      return JSON.parse(resp)
    end

    #PUT/POST /v1/job
    def register_job(spec)
      path = "/job"

      begin
        resp = @rest[path].put(spec)
      rescue StandardError => e
        raise "Error whilst making HTTP request to the Nomad Agent: #{e}"
      end

      return JSON.parse(resp)
    end

    #PUT/POST /v1/job
    def update_job(id, spec)
      path = File.join("/job", id)

      begin
        resp = @rest[path].put(spec)
      rescue StandardError => e
        raise "Error whilst making HTTP request to the Nomad Agent: #{e}"
      end

      return JSON.parse(resp)
    end

    #DELETE /v1/job
    def delete_job(id)
      path = File.join("/job", id)

      begin
        resp = @rest[path].delete
      rescue StandardError => e
        raise "Error whilst making HTTP request to the Nomad Agent: #{e}"
      end

      return JSON.parse(resp)
    end

    #GET /v1/nodes
    def nodes(opts={})
      # Validate options
      supported_opts = ["prefix"]
      raise "Invalid options. Supported: #{supported_opts}" unless opts.keys.reject{ |k| supported_opts.include? k }.empty?

      path = "/nodes"

      begin
        resp = @rest[path].get(:params => opts)
      rescue StandardError => e
        raise "Error whilst making HTTP request to the Nomad Agent: #{e}"
      end

      return JSON.parse(resp)
    end

    #GET /v1/node/<ID>
    def node(id)
      path = File.join("/node", id)

      begin
        resp = @rest[path].get
      rescue StandardError => e
        raise "Error whilst making HTTP request to the Nomad Agent: #{e}"
      end

      return JSON.parse(resp)
    end

    #GET /v1/node/<ID>/allocations
    def node_allocations(id)
      path = File.join("job", id, "allocations")

      begin
        resp = @rest[path].get
      rescue StandardError => e
        raise "Error whilst making HTTP request to the Nomad Agent: #{e}"
      end

      return JSON.parse(resp)
    end

    #PUT/POST /v1/node/<ID>/evaluate
    def create_evaluation(id)
      path = File.join("/node", id, "/evaluate")

      begin
        resp = @rest[path].put
      rescue StandardError => e
        raise "Error whilst making HTTP request to the Nomad Agent: #{e}"
      end

      return JSON.parse(resp)
    end

    def drain(id, enable)
      path = File.join("/node", id, "/drain")
      opts = {:enable => enable}

      begin
        resp = @rest[path].put(nil, :params => opts)
      rescue StandardError => e
        raise "Error whilst making HTTP request to the Nomad Agent: #{e}"
      end

      return JSON.parse(resp)
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
