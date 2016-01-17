#!/bin/sh

mkdir -p ~/.mutt
mkdir -p ~/.mutt/cache
mkdir -p ~/.mutt/temp

ln -s $(readlink -f muttrc) ~/.mutt/muttrc
ln -s $(readlink -f mailcap) ~/.mutt/muttrc
ln -s $(readlink -f view_attachment.sh) ~/.mutt/view_attachment.sh
echo "Please manually edit credentials files in ~/.mutt/"
echo "with the following content:"
cat <<HERE
# Mutt account definition
# YapBreak - 2016

set my_account_name = '<account name>'
set my_imap_server = '<imap server>'
set my_smtp_server = '<stmp server>'
set my_login = '<login>'
set my_password = '<password>'
set my_email = '<email address>'
set my_name = '<real name>'
set my_alternate = '<alternative emails>'
HERE

ln -sf $(readlink -f urlview) ~/.urlview
echo ""
echo "Install urlview to get hypertext link in mutt"
mkdir -p ~/.config/pycard
echo "Install pycarddav to get carddav address book synchronisation"
echo "And fill ~/.config/pycard/pycard.conf with the following configuration:"
cat <<HERE
[Account <account name>]
user: <login>
passwd: <password>
resource: <carddav url>
auth: basic

[sqlite]
path: ~/.mutt/abook.db

[query]
where: vcard

[default]
debug: False
HERE
