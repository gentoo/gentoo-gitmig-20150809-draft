# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/gwget2/gwget2-0.9.ebuild,v 1.1 2004/03/25 02:54:55 pyrania Exp $

inherit gnome2

DESCRIPTION="GTK2 WGet Frontend"
HOMEPAGE="http://gwget.sourceforge.net/"
SRC_URI="mirror://sourceforge/gwget/${P}.tar.gz"
LICENSE="GPL-2"

#IUSE="nls"
IUSE=""
SLOT="0"
KEYWORDS="~x86"

RDEPEND=">=net-misc/wget-1.8
	>=x11-libs/gtk+-2
	>=gnome-base/gconf-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/libglade-2"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=sys-devel/gettext-0.10.4"

DOCS="ABOUT-NLS AUTHORS COPYING ChangeLog INSTALL README THANKS TODO"

# disabling nls breaks atm <foser@gentoo.org>
# still broken in 0.8 <obz@gentoo.org>
#use nls \
#	&& G2CONF="${G2CONF} --enable-nls" \
#	|| G2CONF="${G2CONF} --disable-nls"

src_unpack( ) {

	unpack ${A}
	cd ${S}/src
	# the Makefile defines its own CFLAGS, and then
	# doesnt use user-defined ones, so we need
	# to change that
	sed -i -e "s/^CFLAGS.*$//" Makefile.in

}

src_install( ) {

	gnome2_src_install
	# remove extra documentation, keeping /usr/share/doc
	rm -rf ${D}/usr/doc

}
