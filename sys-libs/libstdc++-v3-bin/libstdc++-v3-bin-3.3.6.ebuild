# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libstdc++-v3-bin/libstdc++-v3-bin-3.3.6.ebuild,v 1.2 2007/11/08 17:37:37 corsair Exp $

DESCRIPTION="Compatibility package for running binaries linked against a pre gcc 3.4 libstdc++"
HOMEPAGE="http://gcc.gnu.org/libstdc++/"
SRC_URI="mirror://gentoo/${PN}-ppc64-${PV}.tbz2"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="ppc64"
IUSE=""

DEPEND=""
RDEPEND="sys-libs/glibc"

RESTRICT="strip"

src_install() {
	cp -pPR "${WORKDIR}"/* "${D}"/ || die "copying files failed!"
}
