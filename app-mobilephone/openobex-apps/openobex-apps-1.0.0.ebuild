# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/openobex-apps/openobex-apps-1.0.0.ebuild,v 1.3 2005/08/16 23:02:56 malc Exp $

inherit eutils

DESCRIPTION="Openobex test applications, including example obexserver to receive files using bluetooth"
HOMEPAGE="http://sourceforge.net/projects/openobex"
SRC_URI="mirror://sourceforge/openobex/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="bluetooth"

DEPEND="dev-libs/openobex
	bluetooth? ( net-wireless/bluez-libs )"
RDEPEND="${DEPEND}
	bluetooth? ( net-wireless/bluez-utils )"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${PN}-printf-fixes.patch
	use bluetooth && epatch ${FILESDIR}/add-obexserver.patch
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc ChangeLog README AUTHORS NEWS
}

pkg_postinst() {
	if use bluetooth ; then
		einfo
		einfo "To use obexserver run: "
		einfo "1. sdptool add --channel=10 OPUSH "
		einfo "2. obexserver "
		einfo
	fi
}