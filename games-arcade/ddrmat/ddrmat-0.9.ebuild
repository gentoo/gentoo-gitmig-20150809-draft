# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/ddrmat/ddrmat-0.9.ebuild,v 1.4 2004/02/20 06:20:00 mr_bones_ Exp $

DESCRIPTION="Kernel module for parallel port Playstation joystick (i.e. DDR mats) adapters"
HOMEPAGE="http://www.icculus.org/pyddr/"
SRC_URI="http://www.icculus.org/pyddr/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/linux-sources"

pkg_setup() {
	[ ${KV:0:4} != "2.4." ] \
		&& eerror "This package only works with 2.4.x kernels" \
		&& die "Failed compile: incompatible kernel"
}

src_compile() {
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc README ChangeLog
	insinto /etc/modules.d
	doins ${FILESDIR}/ddrmat
}

pkg_postinst() {
	[ "${ROOT}" == "/" ] && /sbin/update-modules
	einfo "You can insert the ddrmat module via \"modprobe ddrmat gc=0,7\" or"
	einfo "you can add \"ddrmat\" to your \"/etc/modules.autoload\" to load it"
	einfo "when the system is started."
}
