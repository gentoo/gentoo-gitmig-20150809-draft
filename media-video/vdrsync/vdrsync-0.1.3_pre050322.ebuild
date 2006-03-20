# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/vdrsync/vdrsync-0.1.3_pre050322.ebuild,v 1.5 2006/03/20 15:45:08 zzam Exp $

MY_P="${PN}-${PV#*_pre}"

IUSE="dvdr"
S=${WORKDIR}/vdrsync-${MY_SNAPSHOT}
DESCRIPTION="converting vdr-recordings to mpeg2, dvd or other similar formats"
HOMEPAGE="http://vdrsync.vdr-portal.de/"
SRC_URI="http://vdrsync.vdr-portal.de/releases/${MY_P}.tgz"

KEYWORDS="x86 ~amd64"
SLOT="0"
LICENSE="GPL-2"

DEPEND=""
RDEPEND=">=dev-lang/perl-5.8.0
		media-fonts/corefonts
		dvdr? (
			>=media-libs/gd-2.0.15
			>=dev-perl/GD-2.0.7
			>=dev-perl/GDTextUtil-0.86
			>=media-video/dvdauthor-0.6.8
		)"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}

	cd ${S}
	sed -e "s:/usr/X11R6/lib/X11/fonts/truetype/arial.ttf:/usr/share/fonts/corefonts/arial.ttf:g" \
		-i dvd-menu.pl
}
# vdrsync/dvd-menu use hardcoded tmp-directory for large (up to and
# greater than 1G). Uncomment and change the next two lines to your
# needs if you need another tmp-Dir
#sed -e 's:"/tmp/":"/temp/":g' /usr/bin/dvd-menu.pl
#sed -e 's:"/tmp/":"/temp/":g' /usr/bin/vdrsync.pl

src_install() {
	dobin check-vdrsync.pl vdrsync.pl vdrsync_buffer.pl
	use dvdr && dobin dvd-menu.pl
	dodoc CHANGES
}

