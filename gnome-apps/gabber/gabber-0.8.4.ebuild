# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Frederic Brin <duckx@libertysurf.fr>
# $Header: /var/cvsroot/gentoo-x86/gnome-apps/gabber/gabber-0.8.4.ebuild,v 1.1 2001/07/28 08:24:57 hallski Exp $
#

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="The GNOME Jabber Client"
SRC_URI="http://prdownloads.sourceforge.net/gabber/${A}"
HOMEPAGE="http://gabber.sourceforge.net"

DEPEND=">=gnome-base/gnome-libs-1.2.1
	>=gnome-base/libglade-0.11
	>=gnome-base/gal-0.3
	>=gnome-libs/gnomemm-1.1.12
    	gpg? ( >=app-crypt/gnupg-1.0.5 )
    	ssl? ( >=dev-libs/openssl-0.9.6 )"

src_compile() {
	local myconf

	if ! [ "`use ssl`" ]
	then
	   myconf="--disable-ssl"
	fi

	try ./configure --host=${CHOST} --prefix=/opt/gnome \
                        --sysconfdir=/etc/opt/gnome $myconf 
	try pmake
}

src_install() {
	try make DESTDIR=${D} install
}

