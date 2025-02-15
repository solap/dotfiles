alias cursor="/Applications/Cursor.app/Contents/MacOS/Cursor"
export PATH="$PATH:/Applications/Cursor.app/Contents/MacOS"
PS1='%1~ 🌎 '
# Phoenix aliases
alias phx="clear && iex -S mix phx.server"    # Start Phoenix server with IEx
alias phxc="clear && iex -S mix"              # Start IEx console only
# Phoenix project setup alias
alias psetup='echo "Fetching dependencies..." && \
mix deps.get && \
echo "Creating PostgreSQL role if needed..." && \
createuser -s postgres 2>/dev/null || true && \
echo "Setting up database..." && \
(mix ecto.setup || exit 1) && \
echo "Setup complete!"'
