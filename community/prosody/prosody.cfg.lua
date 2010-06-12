-- Prosody Configuration File
--
-- If it wasn't already obvious, -- starts a comment, and all
-- text after it on a line is ignored by Prosody.
--
-- The config is split into sections, a global section, and one
-- for each defined host that we serve. You can add as many host
-- sections as you like.
--
-- Lists are written { "like", "this", "one" }
-- Lists can also be of { 1, 2, 3 } numbers, and other things.
-- Either commas, or semi-colons; may be used
-- as seperators.
--
-- A table is a list of values, except each value has a name. An
-- example table would be:
--
-- ssl = { key = "keyfile.key", certificate = "certificate.cert" }
--
-- Whitespace (that is tabs, spaces, line breaks) is mostly
-- insignificant, so
-- can
-- be placed anywhere that      you deem fitting.
--
-- Tip: You can check that the syntax of this file is correct when you
-- have finished by running: luac -p prosody.cfg.lua
-- If there are any errors, it will let you know what and where they
-- are, otherwise it
-- will keep quiet.
--
-- The only thing left to do is rename this file to remove the .dist
-- ending, and fill in the
-- blanks. Good luck, and happy Jabbering!

-- Server-wide settings go in this section
Host "*"

    -- This is a (by default, empty) list of accounts that are admins for the
    -- server. Note that you must create the accounts separately (see
    -- http://prosody.im/doc/creating_accounts)
    -- Example: admins = { "user1@example.com", "user2@example.net" }
    admins = { }

    -- This is the list of modules Prosody will load on startup. It looks for
    -- mod_modulename.lua in the plugins folder, so make sure that exists too.
    modules_enabled = {
        -- Generally required
        "roster"; -- Allow users to have a roster. Recommended ;)
        "saslauth"; -- Authentication for clients and servers. Recommended if
                    -- you want to log in.
        "dialback"; -- s2s dialback support
        "disco"; -- Service discovery
        "posix"; -- POSIX functionality, daemonizes, enables syslog, etc.

        -- Not essential, but recommended
        "private"; -- Private XML storage (for room bookmarks, etc.)
        "vcard"; -- Allow users to set vCards
        --"tls"; -- Support for secure TLS on c2s/s2s connections
                 -- Requires optional 'luasec' package
        --"compression";  -- Stream compression for client-to-server streams
                          -- Requires optional 'lua-zlib' package

        -- Nice to have
        "legacyauth"; -- Legacy authentication. Only used by some old
                      -- clients and bots.
        "version"; -- Replies to server version requests
        "uptime"; -- Report how long server has been running
        "time"; -- Let others know the time here on this server
        "ping"; -- Replies to XMPP pings with pongs
        "pep"; -- Enables users to publish their mood, activity, playing music
               -- and more
        "register"; -- Allow users to register on this server using a client
                    -- and change passwords

        -- Other specific functionality
        --"console"; -- telnet to port 5582 (needs console_enabled = true)
        --"bosh"; -- Enable BOSH clients, aka "Jabber over HTTP"
        --"httpserver"; -- Serve static files from a directory over HTTP
        --"groups"; -- Shared roster support
        --"announce"; -- Send announcement to all online users
        --"welcome"; -- Welcome users who register accounts
        --"watchregistrations"; -- Alert admins of registrations
    }

    -- These modules are auto-loaded, should you for (for some mad
    -- reason) want to disable them then uncomment them below.
    modules_disabled = {
        --"presence";
        --"message";
        --"iq";
    }

    -- Disable account creation by default, for security
    -- For more information see http://prosody.im/doc/creating_accounts
    allow_registration = false;

    --These are the SSL/TLS-related settings.
    --ssl = {
    --    key = "certs/localhost.key";
    --    certificate = "certs/localhost.cert";
    --}

    --c2s_require_encryption = false
    --s2s_require_encryption = false

    -- Logging configuration
    log = {
        -- Log all error messages to prosody.err
        { levels = { min = "error" }, to = "file", timestamps = true,
        filename = "/var/log/prosody/prosody.err" };

        -- Log everything except "debug" messages to prosody.log
        { levels = { min = "info" }, to = "file", timestamps = true,
        filename = "/var/log/prosody/prosody.log" };

        -- Log everything to prosody.debug
        --{ levels = { min = "debug" }, to = "file", timestamps = true,
        --filename = "/var/log/prosody/prosody.debug" };
    }

    -- Required for proper deamonization
    pidfile = "/var/run/prosody/prosody.pid"

-- This allows clients to connect to localhost. No harm in it.
Host "localhost"

-- Section for example.com
-- (replace example.com with your domain name)
Host "example.com"

    enabled = false -- This will disable the host, preserving the config, but
                    -- denying connections

    -- Assign this host a certificate for TLS, otherwise it would use the one
    -- set in the global section (if any). Note that old-style SSL on port 5223
    -- only supports one certificate, and will always use the global one.
    --ssl = {
    --    key = "certs/example.com.key";
    --    certificate = "certs/example.com.crt";
    --}

-- Set up a MUC (multi-user chat) room server on conference.example.com:
-- Component "conference.example.com" "muc"
