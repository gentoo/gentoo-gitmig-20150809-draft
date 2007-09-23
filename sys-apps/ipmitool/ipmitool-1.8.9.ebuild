# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/ipmitool/ipmitool-1.8.9.ebuild,v 1.1 2007/09/23 06:03:41 robbat2 Exp $

DESCRIPTION="Utility for controlling IPMI enabled devices."
HOMEPAGE="http://ipmitool.sf.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
IUSE=""
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
LICENSE="BSD"

RDEPEND="virtual/libc
		dev-libs/openssl"
DEPEND="${RDEPEND}
		sys-libs/openipmi
		virtual/os-headers"

src_compile() {
	# LIPMI and BMC are the Solaris libs
	# FreeIPMI is not included at the moment, as ipmitool does not use the
	# correct number of arguments for functions in recent versions.
	econf \
		--enable-ipmievd --enable-ipmishell \
		--enable-intf-lan --enable-intf-lanplus \
		--enable-intf-open --disable-intf-free --enable-intf-imb \
		--disable-intf-lipmi --disable-intf-lipmi \
		--with-kerneldir=/usr --bindir=/usr/sbin \
		|| die "econf failed"
	# Fix linux/ipmi.h to compile properly. This is a hack since it doesn't
	# include the below file to define some things.
	echo "#include <asm/byteorder.h>" >>config.h
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" PACKAGE="${PF}" install || die "emake install failed"

	into /usr
	dosbin contrib/bmclanconf
	rm -f "${D}"/usr/share/doc/${PF}/COPYING
	prepalldocs

	newinitd "${FILESDIR}"/${PN}-1.8.9-ipmievd.initd ipmievd
	newconfd "${FILESDIR}"/${PN}-1.8.9-ipmievd.confd ipmievd
}
