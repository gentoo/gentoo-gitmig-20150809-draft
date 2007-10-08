# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/vdr/vdr-1.2.6-r1.ebuild,v 1.6 2007/10/08 14:14:33 zzam Exp $

inherit eutils check-kernel

DESCRIPTION="Video Disk Recorder - turns a pc into a powerful set top box for DVB"
HOMEPAGE="http://www.cadsoft.de/people/kls/vdr"
SRC_URI="ftp://ftp.cadsoft.de/vdr/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"
IUSE="lirc"

DEPEND="sys-libs/ncurses
	lirc? ( app-misc/lirc )
	media-libs/jpeg
	media-tv/linuxtv-dvb-headers"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-gentoo.diff"
	epatch "${FILESDIR}/${P}_CAN-2005-0071.patch"
}

src_compile() {
	local myconf="VIDEODIR=/etc/vdr"
	use lirc && myconf="${myconf} REMOTE=LIRC"
	emake ${myconf} || die "make failed"
}

src_install() {
	make VIDEODIR=/etc/vdr DESTDIR="${D}" install || die "install failed"
	dodoc COPYING INSTALL README MANUAL CONTRIBUTORS HISTORY
	dohtml PLUGINS.html
	dodir /usr/share/doc/${PF}/scripts
	insinto /usr/share/doc/${PF}/scripts
	doins "${S}"/epg2html.pl "${S}"/runvdr "${S}"/svdrpsend.pl

	# install header files
	dodir /usr/include/vdr
	insinto /usr/include/vdr
	doins *.h
}
