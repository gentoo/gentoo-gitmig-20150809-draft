# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/bluez-libs/bluez-libs-3.36.ebuild,v 1.7 2009/01/08 17:59:59 ranger Exp $

DESCRIPTION="Bluetooth Userspace Libraries"
HOMEPAGE="http://bluez.sourceforge.net/"
SRC_URI="http://bluez.sourceforge.net/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm hppa ppc ppc64 ~sh sparc ~x86"

IUSE="debug"
DEPEND="!net-wireless/bluez-sdp
	!net-wireless/bluez"
RDEPEND="${DEPEND}"

src_compile() {
	econf $(use_enable debug) || die "econf failed"
	if use debug ; then
		echo "#define SDP_DEBUG 1" >> config.h
	fi
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog README || die
}

pkg_postinst() {
	elog "If you are upgrading from =${CATEGORY}/${PN}-2*,"
	elog "the ABI version of libbluetooth has changed."
	elog "Please run:"
	elog "  revdep-rebuild --library libbluetooth.so.1"
}
