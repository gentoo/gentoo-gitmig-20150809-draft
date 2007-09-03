# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/bluez-libs/bluez-libs-3.18.ebuild,v 1.1 2007/09/03 14:27:13 betelgeuse Exp $

inherit libtool

DESCRIPTION="Bluetooth Userspace Libraries"
HOMEPAGE="http://bluez.sourceforge.net/"
SRC_URI="http://bluez.sourceforge.net/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86"

IUSE="debug"
DEPEND="!net-wireless/bluez-sdp"
RDEPEND="${DEPEND}"

src_compile() {
	elibtoolize
	econf $(use_enable debug) || die "econf failed"
	if use debug ; then
		echo "#define SDP_DEBUG 1" >> config.h
	fi
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog README || die

	# http://article.gmane.org/gmane.linux.bluez.announce/57
	# Although library major number changed, API is compatible.
	# Does not work with upgrades because ldconfig changes the symlink
	# to point back to the old version.
	#dosym libbluetooth.so.2 /usr/$(get_libdir)/libbluetooth.so.1
}

pkg_postinst() {
	elog "If you are upgrading from =net-wireless/bluez-util-2*,"
	elog "the ABI version of libbluetooth has changed."
	elog "Please run:"
	elog "  revdep-rebuild --library libbluetooth.so.1"
}
