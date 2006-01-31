# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmsound/wmsound-0.9.5.ebuild,v 1.5 2006/01/31 20:41:56 nelchael Exp $

inherit eutils

IUSE="esd"

DESCRIPTION="WindowMaker sound server"
SRC_URI="http://largo.windowmaker.org/files/${P}.tar.gz"
HOMEPAGE="http://largo.windowmaker.org/"

DEPEND=">=x11-wm/windowmaker-0.80.2-r1
	>=x11-libs/libPropList-0.10.1-r3
	esd? ( >=media-sound/esound-0.2.34 )
	>=media-sound/wmsound-data-1.0.0"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"

src_unpack()
{
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/wmsound-config.patch
	epatch ${FILESDIR}/wmsound-ComplexProgramTargetNoMan.patch
	use esd && epatch ${FILESDIR}/wmsound-esd.patch
}

src_compile()
{
	export PATH="${PATH}:/usr/X11R6/bin"

	cd ${S}
	xmkmf -a
	emake CDEBUGFLAGS="${CFLAGS}" || die "make failed"
}

src_install()
{
	cd ${S}
	einstall PREFIX=${D}/usr USRLIBDIR=${D}/usr/X11R6/lib || die "make install failed"
	dodoc AUTHORS BUGS ChangeLog
}

pkg_postinst()
{
	einfo "WMSound currently supports 8 or 16 bit .wav files."
}
