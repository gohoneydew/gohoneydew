OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'h911UJYONIqKb5HhheqWg', 'GT4n8BAmrRiqFmLVL9CmZCNC0w027q6pI0zunGQgIQ', :image_size => 'original'
  provider :facebook, '830215600338955', '3cd846a4b58d08580368aee4be83b860', :image_size => 'large'
  provider :linked_in, '75q8k9207kx1zz', 'bjoa3TMS1VchdALI', :image_size => 'large'
  #provider :google
end