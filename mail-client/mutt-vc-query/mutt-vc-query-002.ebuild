# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/mutt-vc-query/mutt-vc-query-002.ebuild,v 1.5 2007/01/19 15:26:00 masterdriverz Exp $

MY_PN="mutt_vc_query"
DESCRIPTION="vCard query for mutt (aka rolo)"
HOMEPAGE="http://rolo.sourceforge.net/"
SRC_URI="mirror://sourceforge/rolo/${MY_PN}-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~sparc alpha ~amd64"
IUSE=""

DEPEND="dev-libs/libvc"

S="${WORKDIR}/${MY_PN}-${PV}"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	# we will install later via doman
	rm "${D}/usr/share/man/man1/mutt_vc_query.1"
	dodoc AUTHORS NEWS README THANKS TODO ChangeLog
	doman doc/mutt_vc_query.1
}
