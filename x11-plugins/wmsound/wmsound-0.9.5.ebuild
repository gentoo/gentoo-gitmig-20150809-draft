# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmsound/wmsound-0.9.5.ebuild,v 1.7 2009/01/19 15:21:36 s4t4n Exp $

inherit eutils

IUSE="esd"

DESCRIPTION="WindowMaker sound server"
SRC_URI="http://largo.windowmaker.org/files/${P}.tar.gz"
HOMEPAGE="http://largo.windowmaker.org/"

RDEPEND=">=x11-wm/windowmaker-0.80.2-r1
	>=x11-libs/libPropList-0.10.1-r3
	esd? ( >=media-sound/esound-0.2.34 )
	>=media-sound/wmsound-data-1.0.0"

DEPEND="${RDEPEND}
	x11-misc/imake"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"

src_unpack()
{
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}/wmsound-config.patch"
	epatch "${FILESDIR}/wmsound-ComplexProgramTargetNoMan.patch"
	use esd && epatch "${FILESDIR}/wmsound-esd.patch"

	#Fix compilation with --as-needed.
	sed -i 's:-lPropList $(WMSOUNDLIB):$(WMSOUNDLIB) -lPropList:' src/Imakefile
	sed -i 's:-lPropList $(XLIB) $(WMSOUNDLIB):$(WMSOUNDLIB) -lPropList $(XLIB):' utils/Imakefile
}

src_compile()
{
	export PATH="${PATH}:/usr/X11R6/bin"

	cd "${S}"
	xmkmf -a
	emake CDEBUGFLAGS="${CFLAGS}" || die "make failed"
}

src_install()
{
	cd "${S}"
	einstall PREFIX="${D}/usr" USRLIBDIR="${D}/usr/X11R6/lib" || die "make install failed"
	dodoc AUTHORS BUGS ChangeLog
}

pkg_postinst()
{
	einfo "WMSound currently supports 8 or 16 bit .wav files."
}
