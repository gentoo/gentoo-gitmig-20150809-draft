# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/keytouch/keytouch-2.3.0.ebuild,v 1.2 2007/03/31 06:34:24 nyhm Exp $

inherit eutils versionator linux-info

DESCRIPTION="Easily configure extra keyboard function keys"
HOMEPAGE="http://keytouch.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="acpi kde"

RDEPEND=">=x11-libs/gtk+-2
	gnome-base/gnome-menus
	media-libs/alsa-lib"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
RDEPEND="${RDEPEND}
	acpi? ( sys-power/acpid )
	kde? ( || (
		kde-base/kdesu
		kde-base/kdebase ) )
	!kde? ( x11-libs/gksu )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i 's/install-data-local//1' \
		keytouch{-acpid,d,-init}/Makefile.in \
		|| die "sed failed"

	sed -i 's/gnome-calculator/gcalctool/' \
		keyboards/* || die "sed failed"
}

src_compile() {
	local d
	for d in . keytouch-config keytouch-keyboard ; do
		cd "${S}"/${d}
		econf || die
		emake || die "emake ${d} failed"
	done
}

src_install() {
	if use acpi ; then
		newinitd "${FILESDIR}"/${PN}-acpid ${PN} || die "newinitd failed"
	else
		doinitd "${FILESDIR}"/${PN} || die "doinitd failed"
	fi

	newicon keytouch-keyboard/pixmaps/icon.png ${PN}.png
	make_desktop_entry ${PN} keyTouch ${PN}.png System

	dodoc AUTHORS ChangeLog

	local d
	for d in . keytouch-config keytouch-keyboard ; do
		emake -C ${d} DESTDIR="${D}" install \
			|| die "emake install ${d} failed"
	done
}

pkg_postinst() {
	echo
	elog "To use keyTouch, add \"keytouchd\" to your"
	elog "X startup programs and run"
	elog "\"rc-update add keytouch default\""
	elog
	elog "If support for your keyboard is not included in"
	elog "this release, check for new keyboard files at"
	elog "${HOMEPAGE}dl-keyboards.html"
	elog
	elog "x11-misc/keytouch-editor can be used to create"
	elog "your own keyboard files"
	echo
	if use acpi && ! linux_chkconfig_present INPUT_EVDEV ; then
		ewarn "To add support for ACPI hotkeys, CONFIG_INPUT_EVDEV"
		ewarn "must be enabled in your kernel config."
		ewarn
		ewarn "  Device Drivers"
		ewarn "    Input device support"
		ewarn "      <*>/<M> Event interface"
		echo
	fi
}
