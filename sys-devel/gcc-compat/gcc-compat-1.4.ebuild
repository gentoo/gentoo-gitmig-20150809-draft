# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gcc-compat/gcc-compat-1.4.ebuild,v 1.7 2004/07/15 03:17:56 agriffis Exp $

DESCRIPTION="This is a compatability layer for use when upgrading to profile $PV"
HOMEPAGE="http://www.gentoo.org"
SRC_URI=""
LICENSE="GPL-2"

# Only ONE version of this should exist on a system
# This is ABSOLUTELY Machine non-specific
SLOT="0"
KEYWORDS="x86 ppc sparc "
IUSE=""

DEPEND=""
RDEPEND=""

# DON'T STRIP THE LIBS!
RESTRICT="nostrip"

src_compile() {
	echo -ne ""
}

src_install () {
	cd $ROOT || die "Failed to chdir to root: $ROOT"
	tar cvf ${WORKDIR}/gcc-libs.tar $(find /usr/lib/gcc-lib/ -type f -name '*.so*') || die "failed to create tarball"
	cd ${D} || die "failed to enter \$D: $D"
	tar -mxvf ${WORKDIR}/gcc-libs.tar || die "failed to extract tarball"
}
