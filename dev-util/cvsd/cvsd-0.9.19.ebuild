# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cvsd/cvsd-0.9.19.ebuild,v 1.3 2003/09/06 08:39:20 msterret Exp $

DESCRIPTION="CVS pserver daemon"
HOMEPAGE="http://tiefighter.et.tudelft.nl/~arthur/cvsd/"
SRC_URI="http://tiefighter.et.tudelft.nl/~arthur/cvsd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/glibc"

src_compile() {
	local myconf=""
	use tcpd && myconf="--with-libwrap"
	econf ${myconf} || die
	make || die
}

src_install() {
	dosbin cvsd cvsd-buildroot cvsd-passwd
	insinto /etc/cvsd
	newins cvsd.conf-dist cvsd.conf

	dodoc COPYING* ChangeLog*  FAQ
	dodoc NEWS README* TODO

	doman cvsd-buildroot.8 cvsd-passwd.8 cvsd.8 cvsd.conf.5

	exeinto /etc/init.d ; newexe ${FILESDIR}/cvsd.init cvsd
	insinto /etc/conf.d ; newins ${FILESDIR}/cvsd.confd cvsd
}

pkg_postinst() {
	einfo
	einfo "To configure cvsd please read /usr/share/cvsd-0.9.17/README.gz"
	einfo
}
