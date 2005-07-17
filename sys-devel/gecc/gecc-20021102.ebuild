# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gecc/gecc-20021102.ebuild,v 1.6 2005/07/17 13:39:31 vapier Exp $

DESCRIPTION="tool to speed up compilation of C/C++ sources with compilation distribution and caches"
HOMEPAGE="http://gecc.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""

src_install() {
	einstall || die "Install failed"
	dodoc README

	dodir /usr/bin/gecc_link
	dosym /usr/bin/gecc /usr/bin/gecc_link/gcc
	dosym /usr/bin/gecc /usr/bin/gecc_link/g++
	dosym /usr/bin/gecc /usr/bin/gecc_link/c++
	dosym /usr/bin/gecc /usr/bin/gecc_link/cc

	newconfd ${FILESDIR}/conf.geccd geccd
	newenvd ${FILESDIR}/env.geccd 06geccd
	newinitd ${FILESDIR}/rc.geccd geccd
}

pkg_postinst() {
	einfo
	einfo "To use gecc for you local compiles you will need to add"
	einfo "/usr/bin/gecc/ to the front of your path, and add geccd"
	einfo "to your default runlevel"
	einfo
}
