# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/xmlto/xmlto-0.0.17.ebuild,v 1.3 2004/02/07 03:21:24 pylon Exp $

DESCRIPTION="A bash script for converting XML and DocBook formatted documents to a variety of output formats"
HOMEPAGE="http://cyberelk.net/tim/xmlto/"
SRC_URI="http://cyberelk.net/tim/data/${PN}/stable/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
IUSE=""
KEYWORDS="~x86 ppc ~sparc ~alpha ~ia64 ~amd64"

DEPEND="app-shells/bash
	dev-libs/libxslt
	>=app-text/docbook-xsl-stylesheets-1.62.0-r1
	>=app-text/docbook-xml-dtd-4.2"
#	tetex? ( >=app-text/passivetex-1.4 )"
# Passivetex/xmltex need some sorting out <obz@gentoo.org>

# not parrallel safe, thanks <agriffis@gentoo.org>, bug #33151
MAKEOPTS="${MAKEOPTS} -j1"

src_unpack() {

	unpack ${A}; cd ${S}
	epatch ${FILESDIR}/${PN}-head-fix.patch

}

src_compile() {

	econf || die
	emake || die

}

src_install() {

	make DESTDIR=${D} prefix="/usr" install || die
	dodoc AUTHORS COPYING ChangeLog FAQ INSTALL NEWS README
	insinto /usr/share/doc/${P}/xml
	doins doc/*.xml

}

