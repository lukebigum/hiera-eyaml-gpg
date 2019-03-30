          self.tag = "GPG"
          Config = Struct.new(:executable, :homedir)
          def config
            @config ||=  Config.new("gpg", "~/.gnupg")
          end

          def gpg_command_array
            [
              config.executable,
              '--homedir', config.homedir,
              '--quiet',
              '--no-secmem-warning',
              '--no-permission-warning',
              '--no-tty',
              '--yes'
            ]
          end

          def decrypt_string(string, passphrase = nil)
            command = gpg_command_array.dup
            command << '--passphrase' << passphrase if passphrase
            command << '--decrypt'

            run_command(command, string)
          end

          def run_command(command, input = nil)
            opts = { combine: false }

            output = Puppet::Util::Execution.execute(*command, opts)

            if status.exitstatus != 0
              raise "GPG command (#{command.join(' ')}) failed with: #{error}"
            end

            output
          end
