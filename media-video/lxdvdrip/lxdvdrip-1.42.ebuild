# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/lxdvdrip/lxdvdrip-1.42.ebuild,v 1.4 2006/04/01 12:35:49 flameeyes Exp $

inherit eutils toolchain-funcs

DESCRIPTION="command line tool to automate the process of ripping and burning DVD"
SRC_URI="http://download.berlios.de/lxdvdrip/${P}.tgz"
HOMEPAGE="http://developer.berlios.de/projects/lxdvdrip/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE=""

DEPEND="media-libs/libdvdread"
RDEPEND="${DEPEND}
	>=media-video/dvdauthor-0.6.9
	media-video/streamdvd"

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch "${FILESDIR}/${P}-dvdread.patch"
}

echodo() {
	echo "$@"
	"$@" || die "failed"
}

src_compile() {
	echodo $(tc-getCC) ${CFLAGS} ${LDFLAGS} -o lxdvdrip \
		lxdvdrip.c -lm -ldvdread
}

src_install () {
	dobin lxdvdrip
	dodoc doc-pak/*

	insinto /etc
	newins doc-pak/lxdvdrip.conf.EN lxdvdrip.conf
}
