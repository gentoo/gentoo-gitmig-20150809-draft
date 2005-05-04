# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/hardlink++/hardlink++-0.02.ebuild,v 1.2 2005/05/04 19:09:21 dholm Exp $

inherit eutils
DESCRIPTION="Save disk space by hardlinking identical files."
HOMEPAGE="http://www.sodarock.com/hardlink/"
SRC_URI="${HOMEPAGE}/${P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
DEPEND="sys-devel/gcc"
RDEPEND=""

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-gcc34-optimize-help.patch || die
	epatch ${FILESDIR}/${P}-sane-makefile.patch || die
}

src_compile() {
	# no configure
	emake CXXFLAGS="${CXXFLAGS}" || die "emake failed"
}

src_install() {
	into /usr
	dobin hardlink++
	dodoc README
}
