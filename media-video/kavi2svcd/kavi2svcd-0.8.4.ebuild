# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/kavi2svcd/kavi2svcd-0.8.4.ebuild,v 1.2 2005/08/24 16:22:52 flameeyes Exp $

inherit kde

DESCRIPTION="GUI for generating VCD-compliant MPEG files from an AVI or MPEG file"
HOMEPAGE="http://www.cornelinux.de/web/linux/kavi2svcd/index-english.html"
SRC_URI="mirror://sourceforge/kavi2svcd/${P}-1.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="cdr arts"

DEPEND="sys-apps/sed
	>=media-video/transcode-0.6.6
	>=media-video/mjpegtools-1.6.0-r7
	cdr? ( >=media-video/vcdimager-0.7.19
		>=app-cdr/cdrdao-1.1.7-r1 )"
need-kde 3

S=${WORKDIR}/${PN}

src_unpack() {
	kde_src_unpack
	sed -i 's:;;$:;:' ${S}/src/{prefclass,vcdclass}.h || die
}
