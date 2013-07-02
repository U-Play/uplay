RSpec.configure do |config|
  OmniAuth.config.test_mode = true
  OmniAuth.config.add_mock :facebook, {
    provider: 'facebook',
    uid: '1234567',
    info: {
      email: 'uplay@dummy.com',
      image: 'http://dummy.url.com'
    },
    credentials: { token: 'dummy_token' },
    extra: {
      raw_info: {
        first_name: 'John',
        last_name: 'Doe',
        link: 'http://www.facebook.com/dummy',
      }
    }
  }
end