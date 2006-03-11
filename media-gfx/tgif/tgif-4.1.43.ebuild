# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/tgif/tgif-4.1.43.ebuild,v 1.2 2006/03/11 00:14:25 joshuabaergen Exp $

DESCRIPTION="Tgif is an Xlib base 2-D drawing facility under X11."
HOMEPAGE="http://bourbon.cs.umd.edu:8001/tgif/"
SRC_URI="ftp://bourbon.usc.edu/pub/tgif/free-of-charge/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~ppc"

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
