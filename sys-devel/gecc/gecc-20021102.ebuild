# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gecc/gecc-20021102.ebuild,v 1.4 2004/07/15 03:26:00 agriffis Exp $

IUSE=""
DESCRIPTION="gecc is a tool to speed up compilation of C/C++ sources. It distributes the compilation on a cluster of compilation nodes. It also caches the object files to save some unneeded work."
HOMEPAGE="http://gecc.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
DEPEND="sys-devel/gcc"
RDEPEND="$DEPEND"

src_compile() {
#	rm -rf test
	econf || die "configure failed"
#	patch -p0 < ${FILESDIR}/${P}-gentoo.diff || die
	emake || die "make failed"
}

src_install() {
	einstall || die "Install failed"
	dodoc README

	dodir /usr/bin/gecc_link
	dosym /usr/bin/gecc /usr/bin/gecc_link/gcc
	dosym /usr/bin/gecc /usr/bin/gecc_link/g++
	dosym /usr/bin/gecc /usr/bin/gecc_link/c++
	dosym /usr/bin/gecc /usr/bin/gecc_link/cc

	insinto /etc/conf.d
	newins ${FILESDIR}/conf.geccd geccd

	insinto /etc/env.d
	newins ${FILESDIR}/env.geccd 06geccd

	exeinto /etc/init.d
	newexe ${FILESDIR}/rc.geccd geccd
}

pkg_postinst() {
	einfo
	einfo "To use gecc for you local compiles you will need to add"
	einfo "/usr/bin/gecc to the front of your path, and add geccd"
	einfo "to your default runlevel"
	einfo
}
