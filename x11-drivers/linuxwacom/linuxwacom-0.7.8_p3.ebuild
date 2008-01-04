# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/linuxwacom/linuxwacom-0.7.8_p3.ebuild,v 1.2 2008/01/04 23:03:22 rbu Exp $

inherit eutils autotools

DESCRIPTION="Input driver for Wacom tablets and drawing devices"
HOMEPAGE="http://linuxwacom.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P/_p/-}.tar.bz2"

IUSE="gtk tcl tk usb"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"

RDEPEND="|| ( ( x11-proto/inputproto
		x11-base/xorg-server )
		  virtual/x11 )
	media-libs/libpixman
	gtk? ( >=x11-libs/gtk+-2 )
	tcl? ( dev-lang/tcl )
	tk?  ( dev-lang/tk )
	sys-fs/udev
	sys-libs/ncurses"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	usb? ( >=sys-kernel/linux-headers-2.6 )"
S=${WORKDIR}/${P/_p/-}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Fix multilib-strict error for Tcl/Tk library install
	sed -i -e "s:WCM_EXECDIR/lib:WCM_EXECDIR/$(get_libdir):" configure.in

	epatch "${FILESDIR}"/${P%_p*}-pDev.patch

	eautoreconf
}

src_compile() {
	if use gtk; then
		myconf="--with-gtk=2.0"
	else
		myconf="--with-gtk=no"
	fi

	econf ${myconf} \
		$(use_with tcl tcl) \
		$(use_with tk tk) \
		--enable-wacomdrv --enable-wacdump \
		--enable-xsetwacom --enable-dlloader || die "econf failed"

	unset ARCH
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed."

	insinto /etc/udev/rules.d/
	newins "${FILESDIR}"/xserver-xorg-input-wacom.udev 60-wacom.rules

	dohtml -r docs/*
	dodoc AUTHORS ChangeLog NEWS README
}
