# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-office/gnucash/gnucash-1.6.6.ebuild,v 1.5 2002/07/25 19:29:33 aliz Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A personal finance manager"
SRC_URI="http://download.sourceforge.net/${PN}/${P}.tar.gz"
HOMEPAGE="http://gnucash.sourceforge.net"
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"

RDEPEND=">=gnome-base/gnome-libs-1.4.1.2-r1
	 >=dev-libs/libxml-1.8.10
	 gnome-base/control-center
	 >=gnome-extra/gtkhtml-0.14.0-r1
	 >=gnome-extra/gal-0.13-r1
	 >=gnome-extra/guppi-0.35.5-r2
	 cups? ( >=gnome-base/gnome-print-0.30 )"

DEPEND="${RDEPEND}
	>=sys-devel/perl-5
	>=dev-libs/slib-2.3.8
	>=dev-lang/swig-1.3_alpha4
	>=dev-libs/g-wrap-1.1.5
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}

	cd ${S}/src/guile
	cp argv-list-converters.c argv-list-converters.c.old
	sed -e "s,printf,g_print,g" \
		argv-list-converters.c.old > argv-list-converters.c
	rm argv-list-converters.c.old
}

src_compile() {
	local myconf

	if [ -z "`use nls`" ] ; then
		myconf="--disable-nls"
	fi

	./configure --host=${CHOST}		\
		--prefix=/usr			\
		--mandir=/usr/share/man		\
		--sysconfdir=/etc		\
		$myconf || die

	make || die # Doesn't work with make -j 4 (hallski)
}

src_install () {
    make DESTDIR=${D} install || die

    dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}
