# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/lmctl/lmctl-0.3.2.ebuild,v 1.1 2005/01/08 11:25:42 hollow Exp $

MY_P=${P/-/_}
DESCRIPTION="Utility to change modern logitech mouse parameters"
SRC_URI="http://www.bedroomlan.org/~alexios/files/SOFTWARE/lmctl/${MY_P}.tar.gz"
HOMEPAGE="http://bedroomlan.dyndns.org/~alexios/coding_lmctl.html"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/libc
		>=dev-libs/libusb-0.1.8"

src_unpack() {
	unpack ${A} || die "unpack error"
	mv ${WORKDIR}/lmctl-0.3.1 ${WORKDIR}/lmctl-0.3.2 || die "mv failed"
}

src_compile() {
	econf || die "bad ./configure please submit a bug report to bugs.gentoo.org \
					and include your config.log"
	emake || die "problem compiling lmctl"
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc Changelog README
}
