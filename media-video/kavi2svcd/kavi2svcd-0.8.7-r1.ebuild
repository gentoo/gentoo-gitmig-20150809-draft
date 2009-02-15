# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/kavi2svcd/kavi2svcd-0.8.7-r1.ebuild,v 1.1 2009/02/15 17:15:40 carlo Exp $

ARTS_REQUIRED="never"

inherit kde

DESCRIPTION="GUI for generating VCD-compliant MPEG files from an AVI or MPEG file"
HOMEPAGE="http://www.cornelinux.de/web/linux/kavi2svcd/index-english.html"
SRC_URI="mirror://sourceforge/kavi2svcd/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="vcd"

RDEPEND=">=media-video/transcode-0.6.6
	>=media-video/mjpegtools-1.6.0-r7
	vcd? ( >=dev-libs/libcdio-0.72
	    >=media-video/vcdimager-0.7.21
	    >=app-cdr/cdrdao-1.1.7-r1 )"
DEPEND=""
need-kde 3.5

S="${WORKDIR}/${PN}"

src_unpack() {
	kde_src_unpack

	sed -i 's:;;$:;:' src/{prefclass,vcdclass}.h

	sed -r "s:0\.8\.[^7]:0.8.7:" -i Makefile.in {,src/}config.h admin/Makefile \
		configure{,.in,.in.in}
}
