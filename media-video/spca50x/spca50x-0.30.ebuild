# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/spca50x/spca50x-0.30.ebuild,v 1.1 2004/02/23 08:02:12 phosphan Exp $

DESCRIPTION="Linux device driver for SPCA50X based USB cameras"
HOMEPAGE="http://sourceforge.net/projects/spca50x/"
SRC_URI="mirror://sourceforge/spca50x/${PN}-src-${PV}.tar.gz"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS="-* ~x86"
IUSE=""
DEPEND="virtual/glibc
		virtual/linux-sources"

inherit check-kernel

pkg_setup() {
	get_KV_info
	einfo "Linux kernel ${KV_major}.${KV_minor}.${KV_micro}"
	if is_2_5_kernel || is_2_6_kernel
	then
		eerror "This package only works with 2.4 kernels"
		eerror "Check /usr/src/linux if you _are_ using a 2.4 kernel"
		die "No compatible kernel detected!"
	fi
}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-gentoo.patch
}

src_compile(){
	cd ${WORKDIR}
	emake || die
}

src_install() {
	insinto /lib/modules/${KV}/kernel/drivers/usb
	doins ${WORKDIR}/spca50x.o
	dodoc ${WORKDIR}/README
}

pkg_postinst() {
	/sbin/modules-update &> /dev/null
}
