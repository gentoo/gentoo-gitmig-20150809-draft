# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/mutt-vc-query/mutt-vc-query-002.ebuild,v 1.3 2004/03/14 10:59:03 mr_bones_ Exp $

DESCRIPTION="vCard query for mutt"
HOMEPAGE="http://rolo.sourceforge.net/"
MY_PN="mutt_vc_query"
SRC_URI="mirror://sourceforge/rolo/${MY_PN}-${PV}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
DEPEND="dev-libs/libvc"
RDEPEND="${DEPEND}"
S="${WORKDIR}/${MY_PN}-${PV}"

src_install() {
	emake DESTDIR=${D} install
	rm ${D}/usr/share/man/man1/mutt_vc_query.1 # we will install later via doman
	dodoc AUTHORS COPYING INSTALL NEWS README THANKS TODO ChangeLog
	doman doc/mutt_vc_query.1
}

