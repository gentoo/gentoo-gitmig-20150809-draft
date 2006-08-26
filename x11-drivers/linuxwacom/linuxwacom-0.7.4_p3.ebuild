# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/linuxwacom/linuxwacom-0.7.4_p3.ebuild,v 1.1 2006/08/26 03:03:59 hanno Exp $

IUSE="gtk gtk2 tcltk usb"

inherit eutils

DESCRIPTION="Input driver for Wacom tablets and drawing devices"
HOMEPAGE="http://linuxwacom.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P/_p/-}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"

RDEPEND="|| ( ( x11-proto/inputproto
		x11-base/xorg-server )
	      virtual/x11 )
	gtk? (
		gtk2? ( >=x11-libs/gtk+-2 )
		!gtk2? ( =x11-libs/gtk+-1.2* )
	)
	tcltk? ( dev-lang/tcl dev-lang/tk )
	sys-libs/ncurses"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	usb? ( >=sys-kernel/linux-headers-2.6 )
	>=sys-apps/sed-4"
S=${WORKDIR}/${P/_p/-}


src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/linuxwacom-xorg71.diff
}

src_compile() {
	if use gtk; then
		if use gtk2; then
			myconf="${myconf} --with-gtk=2.0"
		else
			myconf="${myconf} --with-gtk=1.2"
		fi
	else
		myconf="${myconf} --with-gtk=no"
	fi

	econf ${myconf} \
		`use_with tcltk tcl` \
		`use_with tcltk tk` \
		--enable-wacomdrv --enable-wacdump \
		--enable-xsetwacom --enable-dlloader || die

	unset ARCH
	emake || die "build failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed."
	dohtml -r docs/*
	dodoc AUTHORS ChangeLog NEWS README
}
