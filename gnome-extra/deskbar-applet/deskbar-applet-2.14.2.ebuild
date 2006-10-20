# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/deskbar-applet/deskbar-applet-2.14.2.ebuild,v 1.11 2006/10/20 19:10:44 agriffis Exp $

inherit gnome2 eutils autotools

DESCRIPTION="An Omnipresent Versatile Search Interface"
HOMEPAGE="http://raphael.slinckx.net/deskbar/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE="eds"

RDEPEND=">=dev-lang/python-2.3
		 >=x11-libs/gtk+-2.6
		 >=dev-python/pygtk-2.6
		 >=dev-python/gnome-python-2.10
		 >=gnome-base/gnome-desktop-2.10
		 >=dev-python/gnome-python-desktop-2.14.0
		 >=dev-python/gnome-python-extras-2.14
		 >=gnome-base/gconf-2
		 eds? ( >=gnome-extra/evolution-data-server-1.2 )
		 sys-devel/gettext"
DEPEND="${RDEPEND}
		>=dev-util/intltool-0.33
		dev-util/pkgconfig"

pkg_setup() {
	G2CONF="${G2CONF} $(use_enable eds evolution) --exec-prefix=/usr"

	# fix ssh compile problems, bug 132993
	export DISPLAY=""
}

src_unpack() {
	gnome2_src_unpack

	# Fix installing libs into pythondir
	epatch ${FILESDIR}/${PN}-2.13.91-multilib.patch

	AT_M4DIR="m4" \
	eautoreconf
}
