# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/tclap/tclap-1.1.0.ebuild,v 1.3 2009/07/24 18:23:17 ssuominen Exp $

EAPI=2
inherit eutils

DESCRIPTION="Small flexible library for dealing with command line arguments"
HOMEPAGE="http://tclap.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=""
DEPEND=""

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc44.patch
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
