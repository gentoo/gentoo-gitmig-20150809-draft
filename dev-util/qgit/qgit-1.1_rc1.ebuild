# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/qgit/qgit-1.1_rc1.ebuild,v 1.1 2006/01/09 08:16:53 ferdy Exp $

MY_PV=${PV//_/}
MY_P=${PN}-${MY_PV}

DESCRIPTION="GUI interface for git/cogito SCM"
HOMEPAGE="http://digilander.libero.it/mcostalba/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=x11-libs/qt-3.3
	dev-util/scons"
RDEPEND=">=x11-libs/qt-3.3
	>=dev-util/git-0.99.9"

S=${WORKDIR}/${MY_P}

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
