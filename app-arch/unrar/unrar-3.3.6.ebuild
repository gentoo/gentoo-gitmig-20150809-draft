# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/unrar/unrar-3.3.6.ebuild,v 1.1 2004/03/23 10:55:07 aliz Exp $

IUSE=""

inherit eutils

MY_PN=${PN}src
S=${WORKDIR}/unrar
DESCRIPTION="Uncompress rar files"
SRC_URI="http://www.rarlab.com/rar/${MY_PN}-${PV}.tar.gz"
HOMEPAGE="http://www.rarlab.com/rar_add.htm"

SLOT="0"
LICENSE="unRAR"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64"

DEPEND=""

src_compile() {
	emake -f makefile.unix CXXFLAGS="$CXXFLAGS" || die
}

src_install() {
	dobin unrar
	dodoc readme.txt license.txt
}
