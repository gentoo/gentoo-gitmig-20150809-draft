# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/ivman/ivman-0.3.ebuild,v 1.4 2004/11/28 23:09:27 eradicator Exp $

IUSE="debug"

inherit eutils

DESCRIPTION="Daemon to mount/unmount devices, based on info from HAL"
HOMEPAGE="http://ivman.sf.net"
SRC_URI="mirror://sourceforge/ivman/ivman-0.3.tar.gz"

SLOT="0"
LICENSE="QPL"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-libs/glib-2.2
	 dev-libs/libxml2
	 >=sys-apps/hal-0.2.98"

DEPEND="${RDEPEND}
	>=sys-devel/libtool-1.5
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-cvs.update
}

src_compile() {
	econf `use_enable debug` || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die

	exeinto /etc/init.d/
	newexe ${FILESDIR}/${P}.init ivman
}
