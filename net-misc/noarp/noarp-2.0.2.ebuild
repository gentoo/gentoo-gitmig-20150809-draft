# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/noarp/noarp-2.0.2.ebuild,v 1.1 2005/02/25 17:03:05 xmerlin Exp $

inherit check-kernel linux-mod

DESCRIPTION="a kernel module and userspace tool for hiding network interfaces"
HOMEPAGE="http://www.masarlabs.com/noarp/"
SRC_URI="http://www.masarlabs.com/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/linux-sources"
RDEPEND=""

pkg_setup() {
	if is_2_4_kernel
	then
		die "${P} supports only 2.6 kernels"
	fi
}

src_compile() {
	check_KV
	set_arch_to_kernel

	econf --prefix=/ || die
	emake || die
}

src_install() {
	emake DESTDIR=${D} install || die
	dodoc README ChangeLog AUTHORS
}

pkg_postinst() {
	linux-mod_pkg_postinst

	einfo ""
	einfo "Please remember to re-emerge ${PN} when you upgrade your kernel!"
	einfo ""
}