# README

Of course! I can definitely guide you on how to get this Rails app running on a fresh Windows machine.

It's a great question. Since Rails applications have a few dependencies (Ruby, a database, etc.), you can't just open the folder in VS Code and have it run. You need to set up a proper development environment first.

The most reliable and recommended way to do Rails development on Windows today is by using the **Windows Subsystem for Linux (WSL)**. This creates a Linux environment directly inside your Windows machine, which avoids many common compatibility issues that can happen when installing Ruby and its dependencies directly on Windows.

Here is a step-by-step guide to get you from a fresh Windows install to a running Rails app:

### Step 1: Install WSL (Windows Subsystem for Linux)

This is the foundation. It lets you run a Linux system, like Ubuntu, from your Windows terminal.

1.  Open your Windows PowerShell or Command Prompt **as an Administrator**.
2.  Run this single command. It will install WSL and the latest version of Ubuntu Linux for you:
    ```powershell
    wsl --install
    ```
3.  **Restart your computer** when prompted.
4.  After restarting, Ubuntu will finish its installation. You'll be asked to create a username and password for your new Linux environment. Remember these!

### Step 2: Set Up Your Development Environment inside WSL

Now, all the following commands will be run inside your new Ubuntu terminal. You can open it by searching for "Ubuntu" in your Start Menu.

1.  **Update Ubuntu:**
    ```bash
    sudo apt update && sudo apt upgrade
    ```

2.  **Install Git, Node.js, and other essential tools:**
    ```bash
    sudo apt install -y git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libpq-dev nodejs npm
    ```

3.  **Install a Ruby Version Manager (rbenv):** This is the best way to manage Ruby versions.
    ```bash
    # Install rbenv
    git clone https://github.com/rbenv/rbenv.git ~/.rbenv
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
    echo 'eval "$(rbenv init -)"' >> ~/.bashrc
    exec $SHELL

    # Install the ruby-build plugin
    git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
    echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
    exec $SHELL
    ```

4.  **Install Ruby:** Your `Gemfile` specifies version `3.3.1`.
    ```bash
    rbenv install 3.3.1
    rbenv global 3.3.1
    ```

5.  **Install Bundler** (the gem manager for Rails):
    ```bash
    gem install bundler
    ```

### Step 3: Install PostgreSQL Database

Your app uses PostgreSQL, so you need to install and run it within your Linux environment.

1.  **Install PostgreSQL:**
    ```bash
    sudo apt install postgresql postgresql-contrib
    ```
2.  **Start the PostgreSQL service:**
    ```bash
    sudo service postgresql start
    ```
3.  **Create a database user** (it's easiest to name it after your Ubuntu username):
    ```bash
    sudo -u postgres createuser --interactive
    ```
    When prompted, enter your Ubuntu username, and answer 'y' to make it a superuser.

### Step 4: Set Up Your Rails App

1.  **Get the Code:** Inside your Ubuntu terminal, navigate to where you want to store your projects (e.g., `cd ~`) and either clone it with Git or copy the files from your Windows machine. The path to your Windows C: drive is `/mnt/c/`.

2.  **Install App Dependencies:**
    * Navigate into your project folder: `cd your-app-name`
    * Install the required gems: `bundle install`
    * Install the required JS packages: `npm install`

3.  **Configure the Database:**
    * Create the `.env` file as described in the `README.md` to store your database URL. It should look like this, using the username you created in Step 3:
        ```
        DATABASE_URL="postgresql://your_ubuntu_username@localhost/happy_hour_development"
        ```
    * Create your database: `rails db:create`
    * Run the migrations: `rails db:migrate`

### Step 5: Run the App!

1.  **Start the server:**
    ```bash
    bin/dev
    ```
2.  **View in your browser:** Open Chrome or Edge on **Windows** and go to:
    **`http://localhost:3000`**

WSL automatically forwards the ports, so you can access the running server from your regular Windows browser.

### Pro-Tip: Using VS Code with WSL

To make editing a breeze, install the **"WSL" extension** in VS Code. This allows you to open your project *directly from the Linux filesystem* but with the comfort of the Windows VS Code editor.

1.  Open your Ubuntu terminal.
2.  Navigate to your project folder (`cd your-app-name`).
3.  Type the command `code .` (that's `code` space `period`).
4.  This will open your project folder in VS Code, but it will be running in the context of your WSL environment. You can then use the integrated VS Code terminal to run all your `rails` and `git` commands.
