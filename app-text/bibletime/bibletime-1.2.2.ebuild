# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/bibletime/bibletime-1.2.2.ebuild,v 1.2 2002/12/18 14:54:38 vapier Exp $

inherit kde-base
need-kde 3

DESCRIPTION="BibleTime KDE Bible study application using the SWORD library."
HOMEPAGE="http://bibletime.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2
	mirror://sourceforge/${PN}/${PN}-doc-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=app-text/sword-1.5.5"

src_compile() {
	econf
	kde_src_compile

	# Documentation
	S_SAVE=${S}
	S=${WORKDIR}/${PN}-doc-${PV}
	econf || die "configure of documentation failed"
	kde_src_compile
	S=${S_SAVE}
}

src_install() {
	kde_src_install
	dodoc COPYING README INSTALL NEWS TODO ChangeLog

	# Documentation
	S_SAVE=${S}
	S=${WORKDIR}/${PN}-doc-${PV}
	kde_src_install
	S=${S_SAVE}
}
