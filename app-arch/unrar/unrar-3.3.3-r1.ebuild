# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/unrar/unrar-3.3.3-r1.ebuild,v 1.1 2004/01/08 22:02:54 augustus Exp $

inherit eutils

MY_P=${PN}src
S=${WORKDIR}/${PN}
DESCRIPTION="Uncompress rar files"
SRC_URI="http://www.rarlab.com/rar/${MY_P}-${PV}.tar.gz"
HOMEPAGE="http://www.rarlab.com/rar_add.htm"

SLOT="0"
LICENSE="unRAR"
KEYWORDS="~amd64"

DEPEND=""

src_compile() {
	if [ "${ARCH}" = "amd64" ]
	then
		epatch ${FILESDIR}/${PN}-3.3.3-amd64.diff
	fi
	emake -f makefile.unix CXXFLAGS="$CXXFLAGS" || die
}

src_install() {
	dobin unrar
	dodoc readme.txt license.txt
}
