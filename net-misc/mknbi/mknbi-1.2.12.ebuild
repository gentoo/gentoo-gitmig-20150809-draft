# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/mknbi/mknbi-1.2.12.ebuild,v 1.3 2004/03/19 10:11:36 mr_bones_ Exp $

DESCRIPTION="Utility for making tagged kernel images useful for netbooting"
HOMEPAGE="http://etherboot.sourceforge.net"
LICENSE="GPL-2"
SLOT="0"

SRC_FILE="mknbi-1.2.tar.gz"
SRC_URI="mirror://sourceforge/etherboot/${SRC_FILE}"

KEYWORDS="~x86"
IUSE="perl"

DEPEND=">=dev-lang/perl-5.6.1
	dev-lang/nasm"

# Run-time dependencies, same as DEPEND if RDEPEND isn't defined:
#RDEPEND=""

S="${WORKDIR}/mknbi-1.2"

src_unpack() {
	unpack ${A}
	cd ${S}
	echo "test" > __abcdir
	mv Makefile Makefile.org
	cat Makefile.org | sed s/"\/usr\/local"/"\/usr"/ > Makefile
}

src_compile()
{
	make all || die
}

src_install()
{
	export BUILD_ROOT=${D}
	make install || die
}

