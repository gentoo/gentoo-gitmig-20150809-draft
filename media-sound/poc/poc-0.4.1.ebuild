# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/poc/poc-0.4.1.ebuild,v 1.3 2005/07/25 19:05:39 dholm Exp $

inherit eutils

DESCRIPTION="mp3 and ogg streamer (include mp3cue and mp3cut)"
HOMEPAGE="http://www.bl0rg.net/software/poc/"
SRC_URI="http://www.bl0rg.net/software/poc/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="sys-devel/flex
	sys-devel/bison"
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e '/^CFLAGS/s:-O2::' \
		-e '/^PREFIX/s:/local::' \
		Makefile
	epatch "${FILESDIR}"/${P}-fec-pkt-prototype.patch
	epatch "${FILESDIR}"/${P}-file-perms.patch
}

src_install() {
	dodir /usr/bin /usr/share/man/man1
	make install DESTDIR="${D}" || die
	dodoc README TODO
}
