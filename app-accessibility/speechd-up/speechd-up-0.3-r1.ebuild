# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/speechd-up/speechd-up-0.3-r1.ebuild,v 1.1 2006/08/28 03:30:49 williamh Exp $

IUSE=""

inherit eutils

DESCRIPTION="Interface between speakup and speech-dispatcher"
HOMEPAGE="http://www.freebsoft.org/speechd-up"
SRC_URI="http://www.freebsoft.org/pub/projects/speechd-up/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="virtual/libc"
RDEPEND=" app-accessibility/speech-dispatcher"

src_compile() {
	econf || die
	emake CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" || die
}

src_install() {
	make DESTDIR="${D}" install || die
	newinitd ${FILESDIR}/speechd-up.rc speechd-up
	newconfd ${FILESDIR}/speechd-up.confd speechd-up
	dodoc AUTHORS ChangeLog NEWS README TODO
	doinfo speechd-up.info
}
