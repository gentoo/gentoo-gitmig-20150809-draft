# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/insight/insight-6.1.ebuild,v 1.9 2004/11/04 20:30:23 tester Exp $

inherit eutils

IUSE="nls"

DESCRIPTION="A graphical interface to the GNU debugger"
HOMEPAGE="http://sources.redhat.com/insight/index.html"
LICENSE="GPL-2 LGPL-2"
DEPEND="virtual/x11
	sys-libs/ncurses"
RDEPEND="${DEPEND}
	nls? ( sys-devel/gettext )"

SLOT="0"
KEYWORDS="x86 sparc alpha ~ppc ~amd64"
SRC_URI="ftp://sources.redhat.com/pub/gdb/releases/${P}.tar.bz2"

INSIGHTDIR="/opt/insight"

disabled_src_unpack() {

	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/insight-6.1-jimb-copy-section-addr-info.patch
}

src_compile() {

	local myconf
	use nls || myconf="--disable-nls"

	./configure --prefix="${INSIGHTDIR}" \
		--mandir="${D}${INSIGHTDIR}/share/man"	\
		--infodir="${D}${INSIGHTDIR}/share/info"	\
		${myconf} || die
	emake || die

}

src_install () {

	make \
		prefix="${D}${INSIGHTDIR}" \
		mandir="${D}${INSIGHTDIR}/share/man" \
		infodir="${D}${INSIGHTDIR}/share/info" \
		install || die
	insinto /etc/env.d
	doins "${FILESDIR}/99insight"

}
