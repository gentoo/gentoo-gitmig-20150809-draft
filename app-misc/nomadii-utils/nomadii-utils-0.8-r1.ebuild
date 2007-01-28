# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/nomadii-utils/nomadii-utils-0.8-r1.ebuild,v 1.2 2007/01/28 05:22:07 genone Exp $

inherit eutils

IUSE="readline"

MY_P="${P/ii/II}"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="Supports for Creative Nomad II, IIc and II MG under Linux running USB for file transfers and other operations."
HOMEPAGE="http://nomadii.sourceforge.net/"
SRC_URI="mirror://sourceforge/nomadii/${MY_P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND=">=sys-libs/ncurses-5.2
	readline? ( >=sys-libs/readline-4.1 )"

src_unpack() {
	unpack ${A}; cd "${S}"
	epatch "${FILESDIR}/${P}-struct.diff"

	sed -i \
		-e "s:^LIBTERMCAP=-ltermcap$:LIBTERMCAP=-lncurses:" \
		-e "s:^OPTIMIZER= -O2$:OPTIMIZER= ${CFLAGS}:" \
		Makefile

	if ! use readline ; then
		sed -i -e "s:^USE_READLINE=1$:USE_READLINE=0:" \
			Makefile
	fi
}

src_compile() {
	emake || die "compile failure"
}

src_install() {
	dodir /usr/bin /usr/share/man/man1
	dobin nomadii
	newman nomadii.man nomadii.1
}

pkg_postinst() {
	echo
	elog "To use nomadii, you need to have usbdevfs compiled in your kernel"
	elog "Look for: CONFIG_USB_DEVICEFS or Preliminary USB device filesystem"
	echo
	elog "To use nomadii as a regular user, add the following to /etc/fstab"
	elog "   usbdevfs /proc/bus/usb usbdevfs devmode=0660,devgid=85 0 0"
	elog "Remount it, then add the regular user to the usb group"
	elog "   usermod -G usb <username>"
	echo
}
