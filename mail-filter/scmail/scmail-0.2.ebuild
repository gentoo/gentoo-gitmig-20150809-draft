# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/scmail/scmail-0.2.ebuild,v 1.2 2004/06/24 22:22:12 agriffis Exp $

inherit eutils

IUSE=""

HOMEPAGE="http://namazu.org/~satoru/scmail/"
DESCRIPTION="a mail filter written in Scheme"
SRC_URI="http://namazu.org/~satoru/scmail/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"

DEPEND=">=dev-lisp/gauche-0.6.3"

src_unpack() {

	unpack ${A}
	epatch ${FILESDIR}/${P}-gentoo.diff

}

src_compile() {

	emake || die

}

src_install() {

	einstall PREFIX=${D}/usr || die

	dodoc scmailrc*.sample doc/*

}
