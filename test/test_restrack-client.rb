require File.expand_path( File.join( File.dirname(__FILE__), 'helper' ) )

class TestRESTRackClient < Test::Unit::TestCase

  context 'instantiation' do
    should 'accept a String URI' do
      assert_nothing_raised { client_1 = RESTRack::Client.new('http://localhost:9292') }
    end
    should 'accept a URI object' do
      uri = URI.parse('http://localhost:9292')
      assert_nothing_raised { client_2 = RESTRack::Client.new(uri) }
    end
  end

  should 'get a resource' do
    client = RESTRack::Client.new('http://localhost:9292')
    get_response = nil
    assert_nothing_raised do
      get_response = client.responses(1).get
    end
    expected_response = { 'action' => 'show', 'id' => '1' }
    assert_equal expected_response, get_response
  end
  should 'get a collection' do
    client = RESTRack::Client.new('http://localhost:9292')
    get_response = nil
    assert_nothing_raised do
      get_response = client.responses.get
    end
    expected_response = { 'action' => 'index' }
    assert_equal expected_response, get_response
  end

  should 'delete a resource' do
    client = RESTRack::Client.new('http://localhost:9292')
    delete_response = nil
    assert_nothing_raised do
      delete_response = client.responses(1).delete
    end
    expected_response = { 'action' => 'delete', 'id' => '1' }
    assert_equal expected_response, delete_response
  end
  should 'delete a collection' do
    client = RESTRack::Client.new('http://localhost:9292')
    delete_response = nil
    assert_nothing_raised do
      delete_response = client.responses.delete
    end
    expected_response = { 'action' => 'destroy' }
    assert_equal expected_response, delete_response
  end

  should 'post a resource' do
    client = RESTRack::Client.new('http://localhost:9292')
    post_response = nil
    data = {
      'test' => 'data'
    }
    assert_nothing_raised do
      post_response = client.responses(1).post(data)
    end
    expected_response = { 'action' => 'add', 'id' => '1', 'data' => data }
    assert_equal expected_response, post_response
  end
  should 'post a collection' do
    client = RESTRack::Client.new('http://localhost:9292')
    post_response = nil
    data = {
      'test' => 'data'
    }
    assert_nothing_raised do
      post_response = client.responses.post(data)
    end
    expected_response = { 'action' => 'create', 'data' => data }
    assert_equal expected_response, post_response
  end

  should 'put a resource' do
    client = RESTRack::Client.new('http://localhost:9292')
    put_response = nil
    data = {
      'test' => 'data'
    }
    assert_nothing_raised do
      put_response = client.responses(1).put(data)
    end
    expected_response = { 'action' => 'update', 'id' => '1', 'data' => data }
    assert_equal expected_response, put_response
  end
  should 'put a collection' do
    client = RESTRack::Client.new('http://localhost:9292')
    put_response = nil
    data = {
      'test' => 'data'
    }
    assert_nothing_raised do
      put_response = client.responses.put(data)
    end
    expected_response = { 'action' => 'replace', 'data' => data }
    assert_equal expected_response, put_response
  end

  should 'send and parse response json data' do
    client = RESTRack::Client.new('http://localhost:9292', :JSON)
    post_response = nil
    data = {
      'test' => 'data'
    }
    assert_nothing_raised do
      post_response = client.responses(1).post(data)
    end
    expected_response = { 'action' => 'add', 'id' => '1', 'data' => data }
    assert_equal expected_response, post_response
  end
  should 'send and parse response xml data' do
    client = RESTRack::Client.new('http://localhost:9292', :XML)
    post_response = nil
    data = {
      'test' => 'data'
    }
    assert_nothing_raised do
      post_response = client.responses(1).post(data)
    end
    expected_response = { 'action' => 'add', 'id' => '1', 'data' => data }
    assert_equal expected_response, post_response
  end
  #should 'send and parse response yaml data' do
  #  client = RESTRack::Client.new('http://localhost:9292', :YAML)
  #  post_response = nil
  #  data = {
  #    'test' => 'data'
  #  }
  #  assert_nothing_raised do
  #    post_response = client.responses(1).post(data)
  #  end
  #  expected_response = { 'action' => 'add', 'id' => '1', 'data' => data }
  #  assert_equal expected_response, post_response
  #end
  should 'allow building of request path prior to request' do
    client = RESTRack::Client.new('http://localhost:9292')
    object = client.responses(1)
    assert object.class.to_s, 'RESTRack::Client'
    assert object.const_get(:path), '/responses/1'
  end
  should 'pivot' do
    client = RESTRack::Client.new('http://localhost:9292')
    object = client.responses(1)
    get_response = nil
    assert_nothing_raised do
      get_response = object.get
    end
    expected_response = { 'action' => 'show', 'id' => '1' }
    assert_equal expected_response, get_response
  end
  should 'walk a relation path to a child resource' do
    client = RESTRack::Client.new('http://localhost:9292')
    post_response = nil
    data = {
      'test' => 'data'
    }
    assert_nothing_raised do
      post_response = client.parent(1).responses.post(data)
    end
    expected_response = { 'action' => 'add', 'id' => '1', 'data' => data }
    assert_equal expected_response, post_response
  end

  should 'handle multiple sequential requests' do
    client = RESTRack::Client.new('http://localhost:9292')
    get_response = nil
    assert_nothing_raised do
      get_response = client.responses(1).get
    end
    expected_response = { 'action' => 'show', 'id' => '1' }
    assert_equal expected_response, get_response

    get_response = nil
    assert_nothing_raised do
      get_response = client.responses(1).get
    end
    expected_response = { 'action' => 'show', 'id' => '1' }
    assert_equal expected_response, get_response

    get_response = nil
    assert_nothing_raised do
      get_response = client.responses(1).get
    end
    expected_response = { 'action' => 'show', 'id' => '1' }
    assert_equal expected_response, get_response
  end

end
