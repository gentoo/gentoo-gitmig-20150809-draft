# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/rodent/rodent-4.6.2.ebuild,v 1.1 2011/04/02 21:11:42 angelos Exp $

EAPI=4
inherit autotools eutils

DESCRIPTION="a fast, small and powerful file manager and graphical shell"
HOMEPAGE="http://sourceforge.net/projects/xffm/"
SRC_URI="mirror://sourceforge/project/xffm/${PV}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-libs/glib:2
	dev-libs/libxml2:2
	dev-libs/libzip
	x11-libs/gtk+:2
	x11-libs/libSM
	x11-libs/libX11"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool"

DOCS="AUTHORS ChangeLog NEWS README TODO"

src_prepare() {
	epatch "${FILESDIR}"/${P}-libs.patch
	eautoreconf
}
