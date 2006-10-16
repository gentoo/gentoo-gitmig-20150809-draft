# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-ivtvdev/xf86-video-ivtvdev-0.10.6.ebuild,v 1.2 2006/10/16 23:17:21 je_fro Exp $
# SNAPSHOT="yes"

inherit eutils x-modular

DESCRIPTION="X.Org driver for TV-out on ivtvdev cards"
MY_P="ivtv_xdriver_${PV}"
MY_PN="ivtv_xdriver_src_${PV}"
S=${WORKDIR}/${MY_P}/ivtvdrv/xc/programs/Xserver/hw/xfree86/drivers/ivtv/

SRC_URI="http://dl.ivtvdriver.org/xdriver/${PV}/${MY_PN}.tgz"
HOMEPAGE="http://ivtvdriver.org/"
KEYWORDS="~amd64"
LICENSE="X11"
IUSE=""

RDEPEND="x11-base/xorg-server
			media-tv/ivtv"

DEPEND="x11-proto/xextproto
	x11-proto/videoproto
	x11-proto/xproto
	x11-misc/imake
	=x11-base/xorg-server-1.0.2-r7"

# This package is currently broken with xorg-7.1.

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/ivtv_xdriver-unified.patch
	cd ${S}
	sed -i -e "/DependTarget/a USRLIBDIR=\/usr\/$(get_libdir)\/xorg" Imakefile

}

src_compile() {

	xmkmf || die "Running xmkmf failed!"
	x-modular_src_compile || die "make failed"

}

