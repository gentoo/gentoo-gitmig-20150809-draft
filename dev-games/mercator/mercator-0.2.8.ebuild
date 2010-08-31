# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/mercator/mercator-0.2.8.ebuild,v 1.1 2010/08/31 02:26:08 mr_bones_ Exp $

EAPI=2
inherit eutils

DESCRIPTION="WorldForge library primarily aimed at terrain."
HOMEPAGE="http://www.worldforge.org/dev/eng/libraries/mercator"
SRC_URI="mirror://sourceforge/worldforge/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="doc"
SLOT="0"

RDEPEND="dev-games/wfmath"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )
	dev-util/pkgconfig"

src_compile() {
	emake || die "make failed"
	if use doc; then
		emake docs || die "Making doc failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO || die "Installing doc failed"
	if use doc; then
		dohtml doc/html/*  || die "Installing html failed"
	fi
	find "${D}" -type f -name '*.la' -exec rm {} + \
		|| die "la removal failed"
}
