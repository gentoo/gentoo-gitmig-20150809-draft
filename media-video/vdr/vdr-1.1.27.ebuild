# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-video/vdr/vdr-1.1.27.ebuild,v 1.1 2003/04/13 20:54:00 mholzer Exp $

inherit eutils

S="${WORKDIR}/${P}"
DESCRIPTION="VDR - the DVB Video Disk Recorder"
SRC_URI="ftp://ftp.cadsoft.de/vdr/Developer/${P}.tar.bz2"
HOMEPAGE="http://www.cadsoft.de/people/kls/vdr"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
DEPEND="media-video/linuxtv-dvb
	sys-libs/ncurses
	media-libs/jpeg"

src_unpack() {
	unpack "${P}.tar.bz2"
	cd "${S}"
	epatch ${FILESDIR}/${P}-gentoo.diff
}

src_compile() {
	emake || die "make failed"
}

src_install () {
	make DESTDIR=${D} install || die "install failed"
	dodoc COPYING INSTALL README MANUAL CONTRIBUTORS HISTORY
	dohtml PLUGINS.html
	dodir /usr/share/doc/${PF}/scripts
	insinto /usr/share/doc/${PF}/scripts
	doins ${S}/epg2html.pl ${S}/runvdr ${S}/svdrpsend.pl
}
