# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Joe Bormolini <lordjoe@bigfoot.com>

S=${WORKDIR}/${P}
DESCRIPTION="Gtk email client"
SRC_URI="ftp://spruce.sourceforge.net/pub/spruce/devel/${P}.tar.gz"
HOMEPAGE="http://spruce.sourceforge.net/"

DEPEND=">=x11-libs/gtk+-1.2.6"
#	ssl? ( >=dev-libs/openssl-0.9.6 )"
# Doesn't work? Please test =)

src_compile() {

    local myopts
#    if [ "`use ssl`" ]; then
#        myopts="--with-ssl"
#    fi
    try ./configure --prefix=/usr/X11R6 --host=${CHOST} ${myopts}
    try make

}

src_install () {
    try make DESTDIR=${D} install
    dodoc ChangeLog README README.firewall INSTALL
}
