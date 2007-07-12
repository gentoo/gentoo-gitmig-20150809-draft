# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/gwget/gwget-0.6.ebuild,v 1.2 2007/07/12 02:52:15 mr_bones_ Exp $

inherit gnome2

MY_P="gwget2-${PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="GTK2 WGet Frontend"
HOMEPAGE="http://gwget.sourceforge.net/"
SRC_URI="mirror://sourceforge/gwget/${MY_P}.tar.gz"
LICENSE="GPL-2"

IUSE="nls"
SLOT="0"
KEYWORDS="x86"

RDEPEND=">=net-misc/wget-1.8
	>=x11-libs/gtk+-2.0
	>=gnome-base/gconf-2
	>=gnome-base/libgnomeui-2.0
	>=gnome-base/libglade-2.0"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

DOCS="ABOUT-NLS AUTHORS COPYING ChangeLog INSTALL NEWS README THANKS TODO"

use nls \
	&& G2CONF="${G2CONF} --with-included-gettext=no" \
	|| G2CONF="${G2CONF} --disable-nls"

src_unpack() {

	unpack ${A}
	cd ${S}/src
	# the Makefile defines its own CFLAGS, and then
	# doesnt use user-defined ones, so we need
	# to change that
	sed -i -e "s/^CFLAGS.*$//" Makefile.in

}

src_install() {

	gnome2_src_install
	# remove extra documentation, keeping /usr/share/doc
	rm -rf ${D}/usr/doc

}
