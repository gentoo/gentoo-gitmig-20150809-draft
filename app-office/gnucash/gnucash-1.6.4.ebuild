# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-office/gnucash/gnucash-1.6.4.ebuild,v 1.1 2001/10/07 10:48:59 hallski Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A personal finance manager"
SRC_URI="http://download.sourceforge.net/${PN}/${P}.tar.gz"
HOMEPAGE="http://gnucash.sourceforge.net"


RDEPEND=">=gnome-base/gnome-libs-1.4.1.2-r1
	 >=dev-libs/libxml-1.8.10
	 >=gnome-extra/gtkhtml-0.14.0-r1
	 >=gnome-base/gnome-print-0.30
	 >=gnome-extra/gal-0.13-r1
	 >=gnome-extra/guppi-0.35.5-r2"

DEPEND="${RDEPEND}
	>=sys-devel/perl-5
	>=dev-libs/slib-2.3.8
	>=dev-lang/swig-1.3_alpha4
	>=dev-libs/slib-2.3.8
	>=dev-libs/g-wrap-1.1.5
	nls? ( sys-devel/gettext )"

src_compile() {
	local myconf

	if [ -z "`use nls`" ] ; then
        	myconf="--disable-nls"
	fi

	./configure --host=${CHOST}					\
		    --prefix=/usr					\
		    --sysconfdir=/etc					\
		    $myconf || die

	make || die # Doesn't work with make -j 4 (hallski)
}

src_install () {
    make DESTDIR=${D} install || die

    dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}
