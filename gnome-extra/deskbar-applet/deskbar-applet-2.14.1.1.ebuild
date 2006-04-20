# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/deskbar-applet/deskbar-applet-2.14.1.1.ebuild,v 1.1 2006/04/20 23:00:38 allanonjl Exp $

inherit gnome2 eutils autotools

DESCRIPTION="An Omnipresent Versatile Search Interface"
HOMEPAGE="http://raphael.slinckx.net/deskbar/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="eds"

RDEPEND=">=dev-lang/python-2.3
		 >=x11-libs/gtk+-2.6
		 >=dev-python/pygtk-2.6
		 >=dev-python/gnome-python-2.10
		 >=gnome-base/gnome-desktop-2.10
		 >=dev-python/gnome-python-desktop-2.14.0
		 >=dev-python/gnome-python-extras-2.12
		 >=gnome-base/gconf-2
		 eds? ( >=gnome-extra/evolution-data-server-1.2 )
		 sys-devel/gettext"
DEPEND="${RDEPEND}
		>=dev-util/intltool-0.33
		dev-util/pkgconfig"

pkg_setup() {
	G2CONF="${G2CONF} $(use_enable eds evolution) --exec-prefix=/usr"
}

src_unpack() {
	gnome2_src_unpack

	# Fix installing libs into pythondir
	epatch ${FILESDIR}/${PN}-2.13.91-multilib.patch

	AT_M4DIR="m4" \
	eautoreconf
}
