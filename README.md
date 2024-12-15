## Installation

### Bundler

Add this line to your application's Gemfile:

```ruby
gem "commit_msg_ai"
```

And then execute:

```bash
$ bundle install
```

### Making the Script Executable
After installation, if you want to run the commit_msg_ai.rb script directly from the command line, you need to set the executable flag for the file.

If you don’t set the executable flag, you would have to run the Ruby file like this:

```bash
$ ruby lib/commit_msg_ai.rb
```
After running the following command to set the executable flag, you can run the script like this (assuming the file starts with a valid shebang line):

```bash
$ chmod +x lib/commit_msg_ai.rb
$ ./lib/commit_msg_ai.rb
```
This makes the commit_msg_ai.rb file executable, allowing you to run it directly from the terminal without needing to prepend ruby.

### Setting the OPENAI_ACCESS_TOKEN
To use the commit_msg_ai gem, you need to provide your OpenAI API token. This token is required for authenticating requests to the OpenAI API.

Follow these steps to set the OPENAI_ACCESS_TOKEN environment variable:

1. Obtain your OpenAI API key:

Go to OpenAI's API page and generate a new API key.

2. Set the environment variable:

On macOS/Linux: Open your terminal and add the following line to your shell configuration file (~/.bashrc, ~/.zshrc, or ~/.bash_profile depending on the shell you're using):

```bash
export OPENAI_ACCESS_TOKEN="your-api-key-here"
```

After editing the file, run the following command to reload the configuration:

```bash
$ source ~/.bashrc   # or ~/.zshrc, ~/.bash_profile, etc.
```

On Windows:

Open Command Prompt and set the environment variable with the following command:

```cmd
setx OPENAI_ACCESS_TOKEN "your-api-key-here"
```

Alternatively, you can add the environment variable through the System Properties > Environment Variables settings.

3. Verify that the variable is set correctly:

You can check if the environment variable is set by running this command:

```bash
$ echo $OPENAI_ACCESS_TOKEN
```
This should print your OpenAI API key.
