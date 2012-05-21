# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-psb/xf86-video-psb-0.31.0_p14.ebuild,v 1.2 2012/05/21 23:22:50 vapier Exp $

EAPI="2"

inherit rpm autotools eutils

DESCRIPTION="xorg driver for the intel gma500 (poulsbo)"
HOMEPAGE="http://www.happyassassin.net/2009/09/26/gma-500-poulsbo-driver-for-fedora-11-soon-to-be-in-rpm-fusion/"
SRC_URI="http://download1.rpmfusion.org/nonfree/fedora/updates/testing/11/SRPMS/xorg-x11-drv-psb-0.31.0-14.fc11.src.rpm"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="x11-base/xorg-server
	x11-proto/xf86dgaproto
	x11-proto/randrproto
	x11-proto/xf86driproto
	x11-proto/xineramaproto
	x11-libs/libdrm-poulsbo"
RDEPEND="$DEPEND
	x11-drivers/psb-kmod
	x11-libs/xpsb-glx"

S=${WORKDIR}/xserver-xorg-video-psb-0.31.0

src_prepare() {
	epatch "${WORKDIR}/xorg-x11-drv-psb-0.31.0-libdrm.patch"
	epatch "${WORKDIR}/xorg-x11-drv-psb-0.31.0-ignoreacpi.patch"
	epatch "${WORKDIR}/xorg-x11-drv-psb-0.31.0-xserver17.patch"
	eautoreconf
}

src_configure() {
	econf
}

src_compile() {
	emake
}

src_install() {
	emake install DESTDIR="${D}" || die "Make failed"

	elog "If your X refuses to start, saying something like"
	elog "could not mmap framebuffer..."
	elog "try to pretend to have less ram than you have"
	elog "by appending a kernel parameter mem=xxxxMB"
	elog "(especially on a Vaio P11 try mem=2039MB)"
}
