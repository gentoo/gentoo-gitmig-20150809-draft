# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Joe Bormolini <lordjoe@bigfoot.com>
# $Header: /var/cvsroot/gentoo-x86/net-mail/spruce/spruce-0.7.6.ebuild,v 1.4 2001/08/15 19:26:49 lordjoe Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Gtk email client"
SRC_URI="ftp://spruce.sourceforge.net/pub/spruce/devel/${P}.tar.gz"
HOMEPAGE="http://spruce.sourceforge.net/"

RDEPEND=">=x11-libs/gtk+-1.2.6
        gnome-base/libglade
	ssl? ( >=dev-libs/openssl-0.9.6 )
        gpg? ( app-crypt/gnupg )
        gnome? ( gnome-base/gnome-print )"

DEPEND="$RDEPEND nls? ( sys-devel/gettext )"

# Doesn't work? Please test =)

src_compile() {

    local myopts
    if [ -z "`use nls`" ]; then
      myopts="--disable-nls"
    fi
    if [ "`use ssl`" ]; then
      echo "SSL does not work"
      #  myopts="$myopts --with-ssl"
    fi
    if [ "`use gpg`" ] ; then
        myopts="$myopts --enable-pgp"
    else
        myopts="$myopts --disable-pgp"
    fi
    if [ "`use gnome`" ] ; then
        myopts="$myopts --enable-gnome --prefix=/opt/gnome"
    else
        myopts="$myopts --prefix=/usr/X11R6"
    fi

    try ./configure --prefix=/usr/X11R6 --host=${CHOST} ${myopts}
    try make

}

src_install () {
    if [ "`use gnome`" ] ; then
      try make prefix=${D}/opt/gnome install
    else
      try make prefix=${D}/usr/X11R6 install
    fi

    dodoc ChangeLog README README.firewall INSTALL
}
