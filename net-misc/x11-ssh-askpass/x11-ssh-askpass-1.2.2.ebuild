# Copyright 2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author:  Adam Manthei <manthei@sistina.com>

P=x11-ssh-askpass-1.2.2
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="X11-based passphrase dialog for use with OpenSSH"
HOMEPAGE="http://www.ntrnet.net/~jmknoble/software/x11-ssh-askpass/"
SRC_URI="http://www.ntrnet.net/~jmknoble/software/x11-ssh-askpass/${A}"

DEPEND=">=net-misc/openssh-2.3.0 virtual/x11"

src_compile() {
    try ./configure 
    try xmkmf
    try make includes
    try make
}


src_install() {
    newman x11-ssh-askpass.man x11-ssh-askpass.1 
    dobin x11-ssh-askpass
    dodoc ChangeLog README TODO
    docinto html
    dodoc *.html
}
