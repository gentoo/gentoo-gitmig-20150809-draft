# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/leif/leif-11.4.1467.ebuild,v 1.5 2004/06/14 07:21:17 kloeri Exp $

inherit iiimf eutils

DESCRIPTION="Language Engine is a component that provide actual Input Method service for IIIMF"

KEYWORDS="~x86"
IUSE=""

DEPEND="dev-libs/eimil"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.diff
}

src_install() {
	make DESTDIR=${D} \
		prefix=/usr \
		install || die

	dodoc ChangeLog
	for d in canna cm newpy sampleja* ude unit template ; do
		docinto $d
		dodoc ChangeLog README
	done
}
