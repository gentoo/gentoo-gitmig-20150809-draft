# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/actkbd/actkbd-0.2.2.ebuild,v 1.1 2006/03/07 19:45:29 swegener Exp $

inherit linux-info

DESCRIPTION="A keyboard shortcut daemon"
HOMEPAGE="http://www.softlab.ece.ntua.gr/~thkala/projects/actkbd/"
SRC_URI="http://www.softlab.ece.ntua.gr/~thkala/projects/actkbd/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND=""

CONFIG_CHECK="~INPUT_EVDEV"

src_compile() {
	emake CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	dobin actkbd || die "dobin failed"
	dodoc AUTHORS ChangeLog FAQ README TOTO actkbd.conf
}

pkg_postinst() {
	einfo
	einfo "actkbd currently needs the event interface from 2.6 kernels to work. Add"
	einfo "evdev to /etc/modules.autoload.d/kernel-2.6 to have it loaded during boot."
	einfo "System-wide configuration file is /etc/actkbd.conf, but you can use the -c"
	einfo "option to specify a custom configuration file. Use actkbd.conf from"
	einfo "/usr/share/doc/${PF} as a template. We don't install it by default,"
	einfo "because it contains some dangerous examples. You may also need to supply"
	einfo "the -d option to use the right /dev/input/event* device."
	einfo
}
