# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/qmail-qsanity/qmail-qsanity-0.52.ebuild,v 1.3 2004/06/24 23:28:06 agriffis Exp $
DESCRIPTION="qmail-qsanity checks your queue data structures for internal consistency."
HOMEPAGE="http://www.qmail.org/"
SRC_URI="mirror://qmail/${P}"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"
# Should run on all platforms without issue
IUSE=""
DEPEND=""
RDEPEND="mail-mta/qmail dev-lang/perl"
S=${WORKDIR}

src_unpack() {
	cp ${DISTDIR}/${P} ${PN}
}

src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	dobin ${PN}
}
