# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/sary/sary-1.0.5_pre20030426.ebuild,v 1.3 2004/03/01 11:28:26 dholm Exp $

IUSE=""

DESCRIPTION="Sary: suffix array library and tools"
HOMEPAGE="http://sary.namazu.org/"
SRC_URI="http://taiyaki.org/tmp/sary/${PN}-cvs_${PV/*_pre/}.tar.gz"

LICENSE="LGPL-2.1"
KEYWORDS="x86 ~ppc"
SLOT="0"
S="${WORKDIR}/${PN}"

DEPEND=">=dev-libs/glib-2"

src_compile() {

	./autogen.sh
	econf || die
	emake || die

}

src_install() {

	make DESTDIR=${D} \
		docsdir=/usr/share/doc/${PF}/html \
		install || die

	dodoc [A-Z][A-Z]* ChangeLog

}
