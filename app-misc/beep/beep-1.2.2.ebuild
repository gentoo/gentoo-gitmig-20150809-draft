# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/beep/beep-1.2.2.ebuild,v 1.16 2004/07/14 01:43:23 mr_bones_ Exp $

DESCRIPTION="the advanced PC speaker beeper"
HOMEPAGE="http://www.johnath.com/beep/"
SRC_URI="http://www.johnath.com/beep/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc alpha amd64"
IUSE=""

DEPEND="virtual/libc"

src_compile() {
	emake FLAGS="${CFLAGS}" || die "compile problem"
}

src_install() {
	dobin beep
	# do we really have to set this suid by default? -solar
	fperms 4711 /usr/bin/beep
	doman beep.1.gz
	dodoc CHANGELOG CREDITS README
}
