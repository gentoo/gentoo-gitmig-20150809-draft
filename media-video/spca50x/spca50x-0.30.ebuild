# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/spca50x/spca50x-0.30.ebuild,v 1.6 2005/03/09 07:58:41 phosphan Exp $

inherit linux-info eutils

DESCRIPTION="Linux device driver for SPCA50X based USB cameras"
HOMEPAGE="http://sourceforge.net/projects/spca50x/"
SRC_URI="mirror://sourceforge/spca50x/${PN}-src-${PV}.tar.gz"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS="-* ~x86"
IUSE=""
DEPEND="virtual/libc
	virtual/linux-sources"

pkg_setup() {
	if ! kernel_is 2 4
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
