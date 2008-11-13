# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libcompizconfig/libcompizconfig-0.7.8.ebuild,v 1.4 2008/11/13 12:47:21 flameeyes Exp $

EAPI="2"

inherit eutils autotools

DESCRIPTION="Compiz Configuration System (git)"
HOMEPAGE="http://compiz-fusion.org"
SRC_URI="http://releases.compiz-fusion.org/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

RDEPEND="dev-libs/libxml2
	~x11-wm/compiz-${PV}"
DEPEND="${RDEPEND}
	dev-util/intltool
	>=dev-util/pkgconfig-0.19"

src_prepare() {
	epatch "${FILESDIR}/${PN}-undefinedref.patch"

	intltoolize --force || die "intltoolize failed"
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
