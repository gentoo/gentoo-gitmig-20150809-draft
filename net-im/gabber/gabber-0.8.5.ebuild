# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Frederic Brin <duckx@libertysurf.fr>
# $Header: /var/cvsroot/gentoo-x86/net-im/gabber/gabber-0.8.5.ebuild,v 1.1 2001/11/17 21:46:25 verwilst Exp $
#

S=${WORKDIR}/${P}
DESCRIPTION="The GNOME Jabber Client"
SRC_URI="http://prdownloads.sourceforge.net/gabber/${P}.tar.gz"
HOMEPAGE="http://gabber.sourceforge.net"

DEPEND=">=gnome-base/gnome-libs-1.4.1.2-r1
	>=gnome-base/libglade-0.17-r1
	>=gnome-extra/gal-0.13
	>=gnome-extra/gnomemm-1.2.0
	>=x11-libs/gtkmm-1.2.5
    	gpg? ( >=app-crypt/gnupg-1.0.5 )
    	ssl? ( >=dev-libs/openssl-0.9.6 )"

src_compile() {
	local myconf

	if ! [ "`use ssl`" ]
	then
	   myconf="--disable-ssl"
	fi

	./configure --host=${CHOST}					\
		    --prefix=/usr	 				\
		    --sysconfdir=/etc					\
		    --localstatedir=/var/lib				\
   		    $myconf || die

	emake || die
}

src_install() {
	make prefix=${D}/usr						\
	     sysconfdir=${D}/etc					\
	     localstatedir=${D}/var/lib					\
	     install || die
}

