# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/unrar/unrar-3.1.3.ebuild,v 1.7 2005/01/01 12:00:36 eradicator Exp $

inherit eutils

MY_P=${PN}src
DESCRIPTION="Uncompress rar files"
HOMEPAGE="http://www.rarlab.com/rar_add.htm"
SRC_URI="http://www.rarlab.com/rar/${MY_P}-${PV}.tar.gz
	mirror://gentoo/${PN}-gcc3.patch"

LICENSE="unRAR"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa"
IUSE=""

DEPEND=""

S="${WORKDIR}/${PN}"

src_compile() {
	epatch ${DISTDIR}/${PN}-gcc3.patch
	make -f makefile.unix || die
}

src_install() {
	dobin unrar
	dodoc readme.txt license.txt
}
