# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/ivman/ivman-0.4_rc1.ebuild,v 1.2 2004/12/21 21:03:41 genstef Exp $

DESCRIPTION="Daemon to mount/unmount devices, based on info from HAL"
HOMEPAGE="http://ivman.sf.net"
SRC_URI="mirror://sourceforge/ivman/${P}.tar.bz2"
LICENSE="QPL"
KEYWORDS="~amd64 ~x86"
IUSE="debug"
SLOT="0"

RDEPEND=">=dev-libs/glib-2.2
	 dev-libs/libxml2
	 >=sys-apps/hal-0.2.98"
DEPEND="${RDEPEND}
	>=sys-devel/libtool-1.5
	dev-util/pkgconfig
	app-admin/sudo"

src_compile() {
	econf $(use_enable debug) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	exeinto /etc/init.d/
	doexe ${FILESDIR}/ivman-0.3.init ivman
}
