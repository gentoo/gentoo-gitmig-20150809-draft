# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/pcfclock/pcfclock-0.44.ebuild,v 1.2 2004/07/18 11:43:02 dholm Exp $

DESCRIPTION="driver for the parallel port radio clock sold by Conrad Electronic"
HOMEPAGE="http://www-stud.ims.uni-stuttgart.de/~voegelas/pcf.html"
SRC_URI="http://www-stud.ims.uni-stuttgart.de/~voegelas/pcfclock/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND="virtual/linux-sources"

src_compile() {
	econf --with-linux=/usr/src/linux || die
	env -u ARCH emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog NEWS README THANKS
	insinto /etc/modules.d
	newins ${FILESDIR}/pcfclock.modules.d ${PN}
}

pkg_postinst() {
	[ "${ROOT}" == "/" ] && /sbin/update-modules
}
