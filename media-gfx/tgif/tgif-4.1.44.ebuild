# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/tgif/tgif-4.1.44.ebuild,v 1.6 2006/03/11 00:14:25 joshuabaergen Exp $

MY_P="${PN}-QPL-${PV}"
DESCRIPTION="Tgif is an Xlib base 2-D drawing facility under X11."
HOMEPAGE="http://bourbon.usc.edu:8001/tgif/"
SRC_URI="ftp://bourbon.usc.edu/pub/tgif/${MY_P}.tar.gz"

S="${WORKDIR}/${MY_P}"

LICENSE="QPL-1.0"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc-macos ~x86"

RDEPEND="|| ( x11-libs/libXt virtual/x11 )"
DEPEND="${RDEPEND}
	|| ( ( x11-misc/imake
			app-text/rman )
		virtual/x11 )"

src_compile() {
	xmkmf || die "xmkmf failed"
	emake || die "make/compile failed"
}

src_install() {
	make DESTDIR=${D} install || die "install failed"

	## example-files
	dodoc tgif.Xdefaults tgificon.eps tgificon.obj \
		tgificon.xbm tgificon.xpm tangram.sym eq4.sym eq4-2x.sym
	dodoc eq4-ps2epsi.sym eq4-epstool.sym eq4xpm.sym \
		eq4-lyx-ps2epsi.sym keys.obj

	dodoc Copyright README HISTORY
}
