# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/multimon/multimon-1.0-r1.ebuild,v 1.1 2008/11/17 20:37:15 graaff Exp $

S=${WORKDIR}/multimon
SRC_URI="http://www.baycom.org/~tom/ham/linux/multimon.tar.gz"
HOMEPAGE="http://www.baycom.org/~tom/ham/linux/multimon.html"
DESCRIPTION="Multimon decodes digital transmission codes using OSS"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~ppc ~x86"
IUSE=""

RDEPEND="virtual/libc
	x11-libs/libX11"

DEPEND="${RDEPEND}
	x11-proto/xproto"

src_compile() {
	emake CFLAGS="${CFLAGS}"
}

src_install() {
	local myarch
	myarch=`uname -m`
	mv bin-${myarch}/gen bin-${myarch}/multimon-gen
	dobin bin-${myarch}/multimon-gen bin-${myarch}/mkcostab bin-${myarch}/multimon
}

pkg_postinst() {
	ewarn "The gen command has been renamed to multimon-gen to avoid conflicts"
	ewarn "with dev-ruby/gen (#247156)"
}
