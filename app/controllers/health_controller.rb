class HealthController < BareApplicationController
  BUILD_ARGS = {
    build_date: ENV['APP_BUILD_DATE'],
    build_tag: ENV['APP_BUILD_TAG'],
    commit_id: ENV['APP_GIT_COMMIT'],
  }.freeze

  def index
    check = Status.new
    status = check.success? ? :ok : :service_unavailable

    respond_with_status(check.result, status)
  end

  def ping
    respond_with_status(BUILD_ARGS, :ok)
  end

  private

  def respond_with_status(payload, status)
    respond_to do |format|
      format.json { render json: payload, status: status }
    end
  end
end
