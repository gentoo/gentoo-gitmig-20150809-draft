# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/speechd-up/speechd-up-0.3_pre20041029.ebuild,v 1.2 2004/10/30 00:38:57 eradicator Exp $

IUSE=""

inherit eutils

DESCRIPTION="speechup screen reader with software synthesis"
HOMEPAGE="http://www.freebsoft.org/speechd-up"
SRC_URI="http://dev.gentoo.org/~eradicator/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="virtual/libc"

src_compile() {
	econf || die
	emake CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" || die
}

src_install() {
	make DESTDIR="${D}" install || die
	exeinto /etc/init.d
	newexe ${FILESDIR}/speechd-up.rc speechd-up
	dodoc README NEWS BUGS
}
