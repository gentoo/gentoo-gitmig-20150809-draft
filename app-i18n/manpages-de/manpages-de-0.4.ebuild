# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/manpages-de/manpages-de-0.4.ebuild,v 1.2 2002/10/04 04:53:34 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A somewhat comprehensive collection of Linux german man page translations"
echo ${MY_PN}/${P} >/tmp/manpages-de.txt
SRC_URI="http://www.infodrom.org/projects/manpages-de/download/manpages-de-0.4.tar.gz"
HOMEPAGE="http://www.infodrom.org/projects/manpages-de/"
KEYWORDS="x86 ppc"

DEPEND=""
RDEPEND="sys-apps/man"
LICENSE="GPL-2"
SLOT="0"

src_unpack() {
	unpack ${A}
	cd ${S}
}

src_compile() {
	make || die
}
		
src_install() {
	make MANDIR=${D}/usr/share/man/de install  || die
	prepallman
}
