# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mpgtx/mpgtx-1.3.ebuild,v 1.4 2004/07/14 22:02:05 agriffis Exp $

DESCRIPTION="mpgtx a command line MPEG audio/video/system file toolbox"
SRC_URI="mirror://sourceforge/mpgtx/${P}.tgz"
HOMEPAGE="http://mpgtx.sourceforge.net/"

KEYWORDS="~x86"
IUSE=""
SLOT="0"
LICENSE="GPL-2"

DEPEND="sys-libs/glibc"

src_compile() {
	./configure --parachute --prefix=/usr
	emake || die "emake failed"
}

src_install() {
	exeinto /usr/bin
	doexe mpgtx

	dosym /usr/bin/mpgtx /usr/bin/mpgjoin
	dosym /usr/bin/mpgtx /usr/bin/mpgsplit
	dosym /usr/bin/mpgtx /usr/bin/mpgcat
	dosym /usr/bin/mpgtx /usr/bin/mpginfo
	dosym /usr/bin/mpgtx /usr/bin/mpgdemux
	dosym /usr/bin/mpgtx /usr/bin/tagmp3

	doman man/mpgtx.1 man/tagmp3.1

	dosym /usr/share/man/man1/mpgtx.1 /usr/share/man/man1/mpgcat.1
	dosym /usr/share/man/man1/mpgtx.1 /usr/share/man/man1/mpgjoin.1
	dosym /usr/share/man/man1/mpgtx.1 /usr/share/man/man1/mpginfo.1
	dosym /usr/share/man/man1/mpgtx.1 /usr/share/man/man1/mpgsplit.1
	dosym /usr/share/man/man1/mpgtx.1 /usr/share/man/man1/mpgdemux.1

	dodoc AUTHORS COPYING ChangeLog README TODO
}
