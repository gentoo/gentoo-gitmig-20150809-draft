# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/sussen/sussen-0.5.3.ebuild,v 1.4 2004/01/06 20:14:22 weeve Exp $

inherit gnome2 debug

DESCRIPTION="Sussen is a GNOME client for the Nessus Security Scanner"
HOMEPAGE="http://sussen.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~sparc"
IUSE="nls"

RDEPEND=">=gnome-extra/libgnomedb-0.90.0
	>=gnome-extra/libgda-0.90.0
	>=dev-libs/glib-2.2
	>=net-libs/gnet-2.0
	>=gnome-base/libgnomeui-2.2
	>=dev-libs/libxslt-1.0.31"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

DOCS="AUTHORS COPYING ChangeLog INSTALL README TODO"

use nls \
	|| G2CONF="${G2CONF} --disable-nls"

pkg_postinst( ) {

	gnome2_pkg_postinst

	echo ""
	einfo "Please ensure the nessus server has ssl support disabled "
	einfo "before using sussen, as ssl support is currently non-functional"
	einfo "in sussen. More information is available by issuing:"
	einfo ""
	einfo "less /usr/share/doc/${PV}/README.gz"
	echo ""

}
