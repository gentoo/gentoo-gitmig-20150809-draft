# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/ddrmat/ddrmat-0.12.ebuild,v 1.2 2004/10/14 20:13:13 dholm Exp $

DESCRIPTION="Kernel module for parallel port Playstation joystick (i.e. DDR mats) adapters"
HOMEPAGE="http://www.icculus.org/pyddr/"
SRC_URI="http://www.icculus.org/pyddr/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

DEPEND="virtual/linux-sources"

src_compile() {
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc README ChangeLog
	insinto /etc/modules.d
	doins "${FILESDIR}/ddrmat" || die "doins failed"
}

pkg_postinst() {
	[ "${ROOT}" == "/" ] && /sbin/update-modules
	einfo "You can insert the ddrmat module via \"modprobe ddrmat gc=0,7\" or"
	einfo "you can add \"ddrmat\" to your \"/etc/modules.autoload\" to load it"
	einfo "when the system is started."
}
