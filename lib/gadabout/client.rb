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
      valid_opts?(opts,["prefix"])
      path = "/jobs"
      return get(path, opts)
    end

    #GET /v1/job
    def job(id)
      path = File.join("/job", id)
      return get(path)
    end

    #GET /v1/job/<ID>/evaluations
    def job_evaluatons(id)
      path = File.join("/job", id, "/evaluations")
      return get(path)
    end

    #GET /v1/job/<ID>/allocations
    def job_allocations(id)
      path = File.join("/job", id, "/allocations")
      return get(path)
    end

    #PUT/POST /v1/job
    def force_job_evaluation(id)
      path = File.join("/job", id, "/evaluate")
      return put(path)
    end

    #PUT/POST /v1/job
    def force_periodic_job(id)
      path = File.join("/job", id, "/periodic/force")
      return put(path)
    end

    #PUT/POST /v1/job
    def register_job(spec)
      path = "/job/"
      return put(path, nil, spec)
    end

    #PUT/POST /v1/job
    def update_job(id, spec)
      path = File.join("/job", id)
      return put(path, nil, spec)
    end

    #DELETE /v1/job
    def delete_job(id)
      path = File.join("/job", id)
      return delete(path)
    end

    #GET /v1/nodes
    def nodes(opts={})
      valid_opts?(opts,["prefix"])
      path = "/nodes"
      return get(path, opts)
    end

    #GET /v1/node/<ID>
    def node(id)
      path = File.join("/node", id)
      return get(path)
    end

    #GET /v1/node/<ID>/allocations
    def node_allocations(id)
      path = File.join("job", id, "allocations")
      return get(path)
    end

    #PUT/POST /v1/node/<ID>/evaluate
    def create_evaluation(id)
      path = File.join("/node", id, "/evaluate")
      return put(path)
    end

    def drain(id, enable)
      path = File.join("/node", id, "/drain")
      return put(path, {:enable => enable})
    end

    #GET /v1/allocations
    def allocations(opts = {})
      valid_opts?(opts, ['prefix'])
      path = "/allocations"
      return get(path, opts)
    end

    #GET /v1/allocation/<ID>
    def allocation(id)
      path = File.join("/allocation", id)
      return get(path)
    end

    #GET /v1/evaluations
    def evaluations(opts = {})
      valid_opts?(opts, ['prefix'])
      path = "/evaluations"
      return get(path, opts)
    end

    #GET /v1/evaluation/<ID>
    def evaluation(id)
      path = File.join("/evaluation", id)
      return get(path)
    end

    #GET /v1/evaluation/<ID>/allocations
    def evaluation_allocations(id)
      path = File.join("/evaluation", id, 'allocations')
      return get(path)
    end

    #GET /v1/agent/self
    def agent_info
      path = "/agent/self"
      return get(path)
    end

    #PUT/POST /v1/agent/join
    def agent_join(addresses)
      path = "/agent/join"
      return put(path, {:address => addresses})
    end

    #GET /v1/agent/members
    def members
      path = "/agent/members"
      return get(path)
    end

    #PUT/POST /v1/agent/force-leave
    def force_leave(node)
      path = "/agent/force-leave"
      return put(path, {:node => node})
    end

    #GET /v1/agent/servers
    def servers
      path = "/agent/servers"
      return get(path)
    end

    #PUT/POST /v1/agent/servers
    def update_servers(addresses)
      path = "/agent/servers"
      return put(path, {:address => addresses})
    end

    #GET /v1/client/fs/ls
    def client_ls(allocation, path)
      path = File.join("/client/fs/ls", allocation)
      return get(path, {:path => path})
    end

    #GET /v1/client/fs/cat
    def client_cat(allocation, path)
      path = File.join("/client/fs/cat", allocation)
      return get(path, {:path => path})
    end

    #GET /v1/client/fs/stat
    def client_stat(allocation, path)
      path = File.join("/client/fs/cat", allocation)
      return get(path, {:path => path})
    end

    private

    def get(path, params = {})
      begin
        resp = @rest[path].get(:params => params)
      rescue StandardError => e
        raise "Error whilst making HTTP GET request to the Nomad Agent at #{path}: #{e} #{e.response}"
      end

      return JSON.parse(resp)
    end

    def put(path, params, body)
      body ||= ''
      params ||= {}

      begin
        resp = @rest[path].post(body, :params => params)
      rescue StandardError => e
        raise "Error whilst making HTTP PUT request to the Nomad Agent at #{path}: #{e} #{e.response.body}"
      end

      return JSON.parse(resp)
    end

    def delete(path, params = {})
      begin
        resp = @rest[path].delete(:params => params)
      rescue StandardError => e
        raise "Error whilst making HTTP DELETE request to the Nomad Agent at #{path}: #{e} #{e.response}"
      end

      return JSON.parse(resp)
    end

    def valid_opts?(opts, valid)
      raise "Invalid options. Supported: #{valid}" unless opts.keys.reject{ |k| valid.include? k }.empty?
    end
  end
end
