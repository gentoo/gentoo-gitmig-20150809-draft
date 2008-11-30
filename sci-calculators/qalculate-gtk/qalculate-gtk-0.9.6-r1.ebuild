# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-calculators/qalculate-gtk/qalculate-gtk-0.9.6-r1.ebuild,v 1.4 2008/11/30 21:17:43 bluebird Exp $

inherit eutils autotools gnome2

DESCRIPTION="A modern multi-purpose calculator for GNOME"
LICENSE="GPL-2"
HOMEPAGE="http://qalculate.sourceforge.net/"
SRC_URI="mirror://sourceforge/qalculate/${P}.tar.gz"

SLOT="0"
IUSE="gnome nls"
KEYWORDS="amd64 ppc sparc x86"

DEPEND="app-text/scrollkeeper
	dev-lang/perl
	dev-perl/XML-Parser
	>=dev-util/pkgconfig-0.12.0"

RDEPEND=">=sci-libs/libqalculate-0.9.6-r1
	>=x11-libs/gtk+-2.4
	>=gnome-base/libglade-2.0
	gnome? (
		>=gnome-base/libgnome-2.0
		gnome-extra/yelp )
	nls? ( sys-devel/gettext )"

DOCS="AUTHORS ChangeLog NEWS README TODO"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/gtk-crash-fix.patch
	epatch "${FILESDIR}"/${P}-check-fix.patch
	epatch "${FILESDIR}"/${P}-remove-link.patch
	epatch "${FILESDIR}"/${P}-cln-config.patch
	eautoconf
}

src_compile() {
	gnome2_src_compile --disable-clntest
}
