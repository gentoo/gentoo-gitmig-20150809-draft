# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="GUI for perforce version control system"
HOMEPAGE="http://www.perforce.com/"
SRC_URI="http://www.perforce.com/downloads/perforce/r03.2/bin.linux24x86/p4v.tgz"
LICENSE="perforce.pdf"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/glibc"
#RDEPEND=""
S=${WORKDIR}
RESTRICT="nomirror nostrip"

src_unpack ()
{
	unpack ${A}
}

src_compile ()
{
	# do nothing
	echo > /dev/null
}

src_install()
{
	dobin p4v
	mkdir -p ${D}/usr/share/doc/p4v-2003.2
	cp -R P4VResources/p4vhelp/* ${D}/usr/share/doc/p4v-2003.2/
}
