# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/scmail/scmail-1.1.ebuild,v 1.2 2004/06/24 22:22:12 agriffis Exp $

IUSE=""

HOMEPAGE="http://namazu.org/~satoru/scmail/"
DESCRIPTION="a mail filter written in Scheme"
SRC_URI="http://namazu.org/~satoru/scmail/${P}.tar.gz"

LICENSE="BSD"
KEYWORDS="x86"
SLOT="0"

DEPEND=">=dev-lisp/gauche-0.7.4.1"

src_compile() {

	emake || die

}

src_install() {

	einstall \
		PREFIX=${D}/usr \
		SITELIBDIR=${D}$(gauche-config --sitelibdir) \
		DATADIR=${D}/usr/share/doc/${P} \
		|| die

	dohtml doc/*.html

}
