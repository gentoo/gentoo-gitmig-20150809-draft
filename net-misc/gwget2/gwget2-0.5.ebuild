# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/gwget2/gwget2-0.5.ebuild,v 1.1 2003/08/13 03:58:02 obz Exp $

inherit gnome2

DESCRIPTION="GTK2 WGet Frontend"
HOMEPAGE="http://gwget.sourceforge.net/"
SRC_URI="mirror://sourceforge/gwget/${P}.tar.gz"

IUSE="nls"
SLOT="0"
KEYWORDS="~x86"
LICENSE="GPL-2"

RDEPEND=">=net-misc/wget-1.8
		>=x11-libs/gtk+-2.0
		>=gnome-base/gconf-2
		>=gnome-base/libgnomeui-2.0
		nls? ( sys-devel/gettext )"

DEPEND="${RDEPEND}
		dev-util/pkgconfig"
		
DOCS="ABOUT-NLS AUTHORS COPYING ChangeLog INSTALL NEWS README THANKS TODO"

# gwget2 isnt all finished, and there is support for
# gconf planned, so when that comes in, this should be
# okay thanks to the eclass.
		
src_unpack( ) {

	unpack ${A}
	cd ${S}/src
	# the Makefile defines its own CFLAGS, and then
	# doesnt use user-defined ones, so we need
	# to change that
	sed -e "s/^CFLAGS.*$//" < Makefile.in > Makefile.in.tmp
	mv Makefile.in.tmp Makefile.in

}

		
src_compile( ) {

	local myconf
	use nls \
		&& myconf="--with-included-gettext=no" \
		|| myconf="--disable-nls"

	gnome2_src_compile ${myconf}

}

src_install( ) {

	gnome2_src_install
	rm -rf ${D}/usr/doc

}


