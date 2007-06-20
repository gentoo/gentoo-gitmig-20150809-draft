# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/pcsc-lite/pcsc-lite-1.4.2.ebuild,v 1.6 2007/06/20 09:00:17 wolf31o2 Exp $

inherit multilib

STUPID_NUM="1977"
MY_P="${PN}-${PV/_/-}"
DESCRIPTION="PC/SC Architecture smartcard middleware library"
HOMEPAGE="http://www.linuxnet.com/middle.html"
SRC_URI="http://alioth.debian.org/download.php/${STUPID_NUM}/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 ~arm ~hppa ~ia64 ~m68k ppc ppc64 ~s390 ~sh sparc x86"
IUSE="static debug"

RDEPEND="!static? ( dev-libs/libusb )"
DEPEND="dev-libs/libusb
	dev-util/pkgconfig"

S="${WORKDIR}/${MY_P}"

src_compile() {
	econf \
		--docdir="/usr/share/doc/${PF}" \
		--enable-usbdropdir="/usr/$(get_libdir)/readers/usb" \
		--enable-muscledropdir="/usr/share/pcsc/services" \
		--enable-runpid="/var/run/pcscd.pid" \
		$(use_enable debug) \
		$(use_enable static) \
		|| die "configure failed"
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc AUTHORS DRIVERS HELP INSTALL README SECURITY
	prepalldocs

	newinitd "${FILESDIR}"/pcscd-init pcscd
	newconfd "${FILESDIR}"/pcscd-confd pcscd
}

pkg_postinst() {
	ewarn "You should run 'revdep-rebuild --library libpcsclite.so.0'"
}
