# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libtomcrypt/libtomcrypt-0.93.ebuild,v 1.1 2004/01/27 03:21:38 vapier Exp $

inherit eutils

DESCRIPTION="modular and portable cryptographic toolkit"
HOMEPAGE="http://libtomcrypt.org/"
SRC_URI="http://libtomcrypt.org/files/crypt-${PV}.tar.bz2"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="x86 ppc"

src_unpack() {
	unpack ${A} ; cd ${S}
	epatch ${FILESDIR}/${PV}-doc-fix.patch
	epatch ${FILESDIR}/ocb.c.patch
}

src_compile() {
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc authors changes *.pdf
	docinto examples ; dodoc examples/*
	docinto notes ; dodoc notes/*
	docinto demos ; dodoc demos/*
}
