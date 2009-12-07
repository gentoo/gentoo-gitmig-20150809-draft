# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/razertool/razertool-0.0.7-r1.ebuild,v 1.1 2009/12/07 19:19:35 voyageur Exp $

EAPI=2
inherit eutils

DESCRIPTION="Unofficial tool for controlling the Razer Copperhead mouse"
HOMEPAGE="http://razertool.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P/-/_}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk hal"

RDEPEND="=virtual/libusb-0*
	hal? ( >=sys-apps/hal-0.5.7 )
	gtk? (
		>=gnome-base/librsvg-2.0
		>=x11-libs/cairo-1.0.0
		>=x11-libs/gtk+-2.8.0 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	sed -i razertool.rules.example \
		-e 's:ACTION=="add", ::;s:BUS=:SUBSYSTEMS=:;s:SYSFS{:ATTRS{:g' \
		|| die "sed razertool.rules.example action failed"

	if ! use hal ; then
		# plugdev group might not exist (created by hal)
		sed -i razertool.rules.example \
			-e 's:plugdev:root:' \
			|| die "sed razertool.rules.example plugdev failed"
	fi
}

src_configure() {
	econf $(use_enable gtk) || die "econf failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	insinto /etc/udev/rules.d
	newins razertool.rules.example 90-razertool.rules \
		|| die "newins failed"

	dodoc AUTHORS ChangeLog NEWS README

	# Icon and desktop entry
	dosym /usr/share/${PN}/pixmaps/${PN}-icon.png /usr/share/pixmaps/${PN}-icon.png
	make_desktop_entry "razertool-gtk" "RazerTool" ${PN}-icon "GTK;Settings;HardwareSettings"
}

pkg_postinst() {
	elog "Razer Copperhead mice need firmware version 6.20 or higher"
	elog "to work properly. Running ${PN} on mice with older firmwares"
	elog "might lead to random USB-disconnects."
	if use hal ; then
		elog "To run as non-root, add yourself to the plugdev group:"
		elog "   gpasswd -a <user> plugdev"
	else
		elog "To run as non-root, adapt permissions/owner/group in:"
		elog "   /etc/udev/rules.d/90-razertool.rules"
	fi
	elog "Then unplug and plug in the mouse."
}
