# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/xmlto/xmlto-0.0.17.ebuild,v 1.16 2006/03/16 12:59:54 ehmsen Exp $

inherit eutils

DESCRIPTION="A bash script for converting XML and DocBook formatted documents to a variety of output formats"
HOMEPAGE="http://cyberelk.net/tim/xmlto/"
SRC_URI="http://cyberelk.net/tim/data/${PN}/stable/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ppc ~sparc mips alpha arm amd64 ~ia64 ppc64"
IUSE=""

DEPEND="app-shells/bash
	dev-libs/libxslt
	>=app-text/docbook-xsl-stylesheets-1.62.0-r1
	~app-text/docbook-xml-dtd-4.2
	sys-apps/util-linux"

#	tetex? ( >=app-text/passivetex-1.4 )"
# Passivetex/xmltex need some sorting out <obz@gentoo.org>

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-head-fix.patch
}

src_compile() {
	econf || die
	emake -j1 || die
}

src_install() {
	make DESTDIR=${D} prefix="/usr" install || die
	dodoc AUTHORS ChangeLog FAQ NEWS README
	insinto /usr/share/doc/${P}/xml
	doins doc/*.xml
}
