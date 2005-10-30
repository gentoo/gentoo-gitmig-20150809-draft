# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/qgit/qgit-0.96.1.ebuild,v 1.1 2005/10/30 12:05:21 ferdy Exp $

DESCRIPTION="GUI interface for git/cogito SCM"
HOMEPAGE="http://digilander.libero.it/mcostalba/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=x11-libs/qt-3.3
	dev-util/scons"
RDEPEND=">=x11-libs/qt-3.3
	>=dev-util/git-0.99.8f"

src_unpack() {
	unpack ${A} ; cd ${S}

	# If scons sucked less this would be easier
	MY_CXXFLAGS=${CXXFLAGS// /\',\'}
	sed -i -e "s~-O2~${MY_CXXFLAGS}~" SConstruct || die "sed failed"
}

src_compile() {
	scons || die "scons failed"
}

src_install() {
	dobin bin/qgit
	dodoc README ChangeLog
}
