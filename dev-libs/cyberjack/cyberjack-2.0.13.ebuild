# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/cyberjack/cyberjack-2.0.13.ebuild,v 1.1 2007/02/12 13:16:53 wschlich Exp $

inherit eutils flag-o-matic autotools

MY_P="ctapi-${P}"

DESCRIPTION="REINER SCT cyberJack pinpad/e-com USB user space driver library"
HOMEPAGE="http://www.reiner-sct.de/ http://sourceforge.net/projects/libchipcard/"
SRC_URI="mirror://sourceforge/libchipcard/${MY_P}.tar.gz
	http://support.reiner-sct.de/downloads/LINUX/V${PV}/${MY_P}.tar.gz"
LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="noudev pcsc-lite"
RDEPEND="
	dev-libs/libusb
	pcsc-lite? (
		sys-apps/pcsc-lite
		dev-util/pkgconfig
	)
"
DEPEND="${RDEPEND}"
S="${WORKDIR}/${MY_P}"

pkg_setup() {
	useq noudev || enewgroup "${PN}"
}

src_unpack() {
	unpack ${A} || die "Unpacking failed."
	cd "${S}" || die "Failed to change to source directory."
	epatch "${FILESDIR}/${P}-build.patch" || die "Applying build patch failed."
	epatch "${FILESDIR}/${P}-qa.patch" || die "Applying QA patch failed."
	useq noudev || {
		epatch "${FILESDIR}/${P}-udev.patch" || die "Applying udev patch failed."
		cp ${FILESDIR}/cyberjack.sh etc/udev/ || die "Copying udev script failed."
		cp ${FILESDIR}/91-cyberjack.rules etc/udev/ || die "Copying udev rules failed."
	}
	AT_M4DIR="m4" eautoreconf || die "Adopting configurations failed."
}

src_compile() {
	append-flags -fno-strict-aliasing
	./configure \
		--prefix=/usr \
		--docdir=/usr/share/doc/"${P}" \
		--sysconfdir=/etc/"${PN}" \
		$(use_enable pcsc-lite pcsc) \
		$(use_with pcsc-lite usbdropdir=$(pkg-config libpcsclite --variable=usbdropdir)) \
		$(use_enable !noudev udev) \
		|| die "Configuration of package failed."
	emake || die "Compilation of package failed."
}

src_install() {
	emake install DESTDIR="${D}" || die "Installation of package failed."
	dodoc ChangeLog NEWS README TODO tools/ctshrc.example

	# remove development files
	rm -rf "${D}"/usr/include/ \
		"${D}"/usr/lib/*.la \
		"${D}"/usr/lib/readers/usb/ifd-"${PN}".bundle/Contents/Linux/*.la
}

pkg_postinst() {
	local conf="/etc/${PN}/${PN}.conf"
	einfo
	einfo "To configure logging, key beep behaviour etc. you need to"
	einfo "copy ${conf}.default"
	einfo "to ${conf}"
	einfo "and modify the latter as needed."
	einfo
	useq noudev || {
		einfo "Please run the following command as root to"
		einfo "make udevd read the cyberJack rules that were"
		einfo "just installed onto your system:"
		einfo
		einfo "  udevcontrol reload_rules"
		einfo
		einfo "To be able to use the cyberJack device, you need to"
		einfo "be a member of the group 'cyberjack' which has just"
		einfo "been added to your system. You can add your user to"
		einfo "the group by running the following command as root:"
		einfo
		einfo "  gpasswd -a youruser cyberjack"
		einfo
		einfo "Please be aware that you need to re-login to your"
		einfo "system for the group membership to take effect."
		einfo
	}
}
