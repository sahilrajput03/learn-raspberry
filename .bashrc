# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

alias e='exit'
alias vi.bashrc='vi ~/.bashrc'
alias ...='source ~/.bashrc'
alias cd.skypebot='cd /home/pi/Documents/skype-bot-with-heroku-webhook-for-build-notifications/skype-bot'

alias vi.pf='sudo vi /etc/postfix/main.cf'
alias pf.reload='sudo postfix reload'
alias pf.restart='sudo /etc/init.d/postfix restart'
alias pf.telnet='telnet localhost 25'
alias pf.logFollow='tail -f /var/log/mail.log'
alias pf.cdMails='cd /var/spool/mail'
alias pf.status='systemctl status postfix'



# dovecot
alias vi.dovecot='sudo vi /etc/dovecot/dovecot.conf'
alias dc.restart='sudo service dovecot restart'

# cd to directory directly by entering directory names ~Sahil
shopt -s autocd


# apache
alias ap.reload='sudo service apache2 reload'

# restart mongod
alias mongod.restart='sudo systemctl restart mongodb'
alias mongod.status='sudo systemctl status mongodb'
alias mongod.start='sudo systemctl start mongodb'


# Enable case-insensitive cd path completions
bind "set completion-ignore-case on"

# Run program in detached state i.e., `nohup script.sh &`
function air {
        nohup "$@" > /dev/null 2>&1 &
}
