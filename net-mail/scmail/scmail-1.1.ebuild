# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/scmail/scmail-1.1.ebuild,v 1.1 2004/02/08 13:18:49 hattya Exp $

IUSE=""

HOMEPAGE="http://namazu.org/~satoru/scmail/"
DESCRIPTION="a mail filter written in Scheme"
SRC_URI="http://namazu.org/~satoru/scmail/${P}.tar.gz"

LICENSE="BSD"
KEYWORDS="~x86"
SLOT="0"
S="${WORKDIR}/${P}"

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
