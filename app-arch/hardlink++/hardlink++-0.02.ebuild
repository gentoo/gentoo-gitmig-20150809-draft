# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/hardlink++/hardlink++-0.02.ebuild,v 1.3 2005/10/17 00:11:59 malc Exp $

inherit eutils
DESCRIPTION="Save disk space by hardlinking identical files."
HOMEPAGE="http://www.sodarock.com/hardlink/"
SRC_URI="${HOMEPAGE}/${P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
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
