def handle_router with_action: 'NO ACTION', and_route: '/nowhere', and_params: {}
  action, route, params = with_action, and_route, and_params

  params = params.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}
  handle = get_handle with_action: action, and_route: route

  return nil if handle.nil?

  pipeline, presenter, view = build_ppv from_handle: handle
  pipeline_params = build_params from_params: params, with_keys: handle[:params]
  presenter_data = presenter.build(with_data: pipeline.execute(with_params: pipeline_params))

  view.render with_data: presenter_data, named: handle[:view_name]
end


def get_handle with_action: 'NO ACTION', and_route: '/nowhere'
  action, route = with_action, and_route
  key = "[#{action}] #{route}"
  ROUTES[key]
end


def build_ppv from_handle: nil
  handle = from_handle

  pipeline = Kernel.const_get(handle[:pipeline])
  presenter = Kernel.const_get(handle[:presenter])
  view = Kernel.const_get(handle[:view_engine])
  
  return pipeline, presenter, view
end


def build_params from_params: nil, with_keys: nil
  params, keys = from_params, with_keys

  params.select { |key,_| keys.include? key }
end


