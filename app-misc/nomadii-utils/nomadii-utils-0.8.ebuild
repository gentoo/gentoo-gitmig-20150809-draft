# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/nomadii-utils/nomadii-utils-0.8.ebuild,v 1.9 2004/02/29 17:20:00 aliz Exp $

IUSE="readline"

MY_P=${P/ii/II}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Supports for Creative Nomad II, IIc and II MG under Linux running USB for file transfers and other operations."
HOMEPAGE="http://nomadii.sourceforge.net/"
SRC_URI="mirror://sourceforge/nomadii/${MY_P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=sys-libs/ncurses-5.2
	readline? ( >=sys-libs/readline-4.1 )"

src_compile() {
	sed -i -e "s:^LIBTERMCAP=-ltermcap$:LIBTERMCAP=-lncurses:" \
		Makefile

	sed -i -e "s:^OPTIMIZER= -O2$:OPTIMIZER= ${CFLAGS}:" \
		Makefile

	if [ -z "`use readline`" ] ; then
		sed -i -e "s:^USE_READLINE=1$:USE_READLINE=0:" \
			Makefile
	fi

	emake || die "compile failure"
}

src_install() {
	dodir /usr/bin /usr/share/man/man1
	dobin nomadii
	newman nomadii.man nomadii.1
}

pkg_postinst() {
	if ! groupmod usb; then
		groupadd -g 85 usb || die "problem adding group usb"
	fi

	echo
	einfo "To use nomadii, you need to have usbdevfs compiled in your kernel"
	einfo "Look for: CONFIG_USB_DEVICEFS or Preliminary USB device filesystem"
	echo
	einfo "To use nomadii as a regular user, add the following to /etc/fstab"
	einfo "   usbdevfs /proc/bus/usb usbdevfs devmode=0660,devgid=85 0 0"
	einfo "Remount it, then add the regular user to the usb group"
	einfo "   usermod -G usb <username>"
	echo
}
