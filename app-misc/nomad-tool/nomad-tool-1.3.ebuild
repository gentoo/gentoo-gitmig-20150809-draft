# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/nomad-tool/nomad-tool-1.3.ebuild,v 1.2 2003/09/05 12:10:36 msterret Exp $

DESCRIPTION="Controls the Nomad II MG and IIc portable MP3 players"
HOMEPAGE="http://www.swiss.ai.mit.edu/~cph/nomad.php"
SRC_URI="http://www.swiss.ai.mit.edu/~cph/nomad/${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86"
LICENSE="GPL-2"
IUSE=""

DEPEND=""

src_unpack() {
	unpack ${A}
}

src_compile() {
	cd ${WORKDIR}
	make PREFIX="/usr" || die
}

src_install() {
	cd ${WORKDIR}
	dobin nomad-tool
	dolib nomad-open
	doman nomad-tool.1
}

pkg_postinst() {
	chmod 4755 /usr/lib/nomad-open
}

