# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-ivtv/xf86-video-ivtv-0.10.6.ebuild,v 1.1 2008/01/31 06:24:51 je_fro Exp $

inherit eutils x-modular

DESCRIPTION="X.Org driver for TV-out on ivtvdev cards"
MY_P="ivtv_xdriver_${PV}"
MY_PN="ivtv_xdriver_src_${PV}"
S=${WORKDIR}/${MY_P}/ivtvdrv/xc/programs/Xserver/hw/xfree86/drivers/ivtv/

SRC_URI="http://dl.ivtvdriver.org/xdriver/${PV}/${MY_PN}.tgz
		mirror://gentoo/${PF}.patch.tar.bz2"
HOMEPAGE="http://ivtvdriver.org/"
KEYWORDS="~amd64 ~x86"
LICENSE="X11"
IUSE=""

RDEPEND="x11-base/xorg-server
			media-tv/ivtv"

DEPEND="x11-proto/xextproto
	x11-proto/videoproto
	x11-proto/xproto
	x11-misc/imake
	>=x11-base/xorg-server-1.1.1-r4"

src_unpack() {
	unpack ${A}
	epatch ${DISTDIR}/${PF}.patch.tar.bz2
	cd ${S}
	sed -i -e "/DependTarget/a USRLIBDIR=\/usr\/$(get_libdir)\/xorg" Imakefile

}

src_compile() {

	xmkmf || die "Running xmkmf failed!"
	x-modular_src_compile || die "make failed"

}
