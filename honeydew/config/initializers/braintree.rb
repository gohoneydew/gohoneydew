Braintree::Configuration.environment = :sandbox
Braintree::Configuration.logger = Logger.new('log/braintree.log')
Braintree::Configuration.merchant_id = ENV['s8ybds2m8369vhrm']
Braintree::Configuration.public_key = ENV['dsb8zrthhnvynjxs']
Braintree::Configuration.private_key = ENV['60e861ab56f4e89f00043c01ef5e4635']