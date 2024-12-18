## Installation

### Bundler

To install the gem locally, run:

```bash
gem install "commit_msg_ai"
```
This gem is meant to be used locally and does not need to be added to your Gemfile.

### Making the Script Executable
First, ensure the script has executable permissions:
```bash
$ chmod +x bin/commit_msg_ai
```
This makes the file runnable as a script. You can now run the executable directly from the terminal:
```bash
$ ./bin/commit_msg_ai
```

### Setting the `OPENAI_ACCESS_TOKEN`
To use the commit_msg_ai gem, you need to provide your OpenAI API token. This token is required for authenticating requests to the OpenAI API. Follow these steps to set the OPENAI_ACCESS_TOKEN environment variable:

**1. Obtain your OpenAI API key:**

Go to OpenAI's API page and generate a new API key.

**2. Set the environment variable:**

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

**3. Verify that the variable is set correctly:**

You can check if the environment variable is set by running this command:

```bash
$ echo $OPENAI_ACCESS_TOKEN
```
This should print your OpenAI API key.
