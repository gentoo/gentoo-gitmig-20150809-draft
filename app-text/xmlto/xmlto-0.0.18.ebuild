# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/xmlto/xmlto-0.0.18.ebuild,v 1.9 2005/04/01 17:03:57 blubb Exp $

inherit eutils

DESCRIPTION="A bash script for converting XML and DocBook formatted documents to a variety of output formats"
HOMEPAGE="http://cyberelk.net/tim/xmlto/"
SRC_URI="http://cyberelk.net/tim/data/xmlto/stable/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm ia64 ~mips ppc ~ppc64 sparc x86 hppa"
IUSE=""

DEPEND="app-shells/bash
	dev-libs/libxslt
	>=app-text/docbook-xsl-stylesheets-1.62.0-r1
	=app-text/docbook-xml-dtd-4.2*"
#	tetex? ( >=app-text/passivetex-1.4 )"
# Passivetex/xmltex need some sorting out <obz@gentoo.org>

src_compile() {
	econf || die
	emake -j1 || die
}

src_install() {
	make DESTDIR=${D} prefix="/usr" install || die
	dodoc AUTHORS ChangeLog FAQ INSTALL NEWS README
	insinto /usr/share/doc/${P}/xml
	doins doc/*.xml
}
