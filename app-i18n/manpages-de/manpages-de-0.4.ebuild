# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/manpages-de/manpages-de-0.4.ebuild,v 1.7 2004/04/05 10:59:32 gmsoft Exp $

DESCRIPTION="A somewhat comprehensive collection of Linux german man page translations"
echo ${MY_PN}/${P} >/tmp/manpages-de.txt
SRC_URI="http://www.infodrom.org/projects/manpages-de/download/manpages-de-0.4.tar.gz"
HOMEPAGE="http://www.infodrom.org/projects/manpages-de/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc hppa"

RDEPEND="sys-apps/man"
DEPEND=""

src_compile() {
	make prefix=${D}/usr/share || die
}

src_install() {
	make MANDIR=${D}/usr/share/man/de install  || die
	prepallman

	dodoc CHANGES COPYRIGHT README
}
