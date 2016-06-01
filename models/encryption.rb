require('base64')
class Encrypt

    def self.value(value)

        cipher = OpenSSL::Cipher.new('AES-128-CBC')
        cipher.encrypt
        cipher.key = "akphgvjjhkhbkjhfaksldjfnvghui87gERD"
        cipher.iv = "askbkbhbhfiasiw3hn8ht4484"
        encrypted = cipher.update(value) + cipher.final
        return Base64.encode64(encrypted).encode('utf-8').chomp
    end

end
