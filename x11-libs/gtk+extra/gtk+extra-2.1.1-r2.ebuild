# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtk+extra/gtk+extra-2.1.1-r2.ebuild,v 1.1 2008/05/31 13:13:56 remi Exp $

inherit gnome2 eutils

DESCRIPTION="Useful Additional GTK+ widgets"
HOMEPAGE="http://gtkextra.sourceforge.net"
SRC_URI="mirror://sourceforge/scigraphica/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.0
		>=dev-libs/glib-2.0"
DEPEND="${RDEPEND}
		dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog INSTALL README"

src_unpack() {
	gnome2_src_unpack

	# patches to fix segfaults, see bug #219777
	epatch "${FILESDIR}/${PN}-2.1.1-glib2.10-full-fix.patch"
	epatch "${FILESDIR}/${PN}-2.1.1-fix-row-deletion-segfault.patch"
}
