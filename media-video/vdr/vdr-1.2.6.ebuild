# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/vdr/vdr-1.2.6.ebuild,v 1.1 2003/12/12 14:56:16 aliz Exp $

inherit eutils

DESCRIPTION="Klaus Schmidingers Video Disk Recorder"
HOMEPAGE="http://www.cadsoft.de/people/kls/vdr"
SRC_URI="ftp://ftp.cadsoft.de/vdr/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="lirc"

DEPEND="media-tv/linuxtv-dvb
	sys-libs/ncurses
	lirc? ( app-misc/lirc )
	media-libs/jpeg"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.diff
}

src_compile() {
	local myconf="VIDEODIR=/etc/vdr"
	use lirc && myconf="${myconf} REMOTE=LIRC"
	emake ${myconf} || die "make failed"
}

src_install() {
	make VIDEODIR=/etc/vdr DESTDIR=${D} install || die "install failed"
	dodoc COPYING INSTALL README MANUAL CONTRIBUTORS HISTORY
	dohtml PLUGINS.html
	dodir /usr/share/doc/${PF}/scripts
	insinto /usr/share/doc/${PF}/scripts
	doins ${S}/epg2html.pl ${S}/runvdr ${S}/svdrpsend.pl

	# install header files
	dodir /usr/include/vdr
	insinto /usr/include/vdr
	doins *.h
}
