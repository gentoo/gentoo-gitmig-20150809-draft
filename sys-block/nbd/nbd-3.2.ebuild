# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/nbd/nbd-3.2.ebuild,v 1.8 2012/10/17 03:33:03 phajdan.jr Exp $

EAPI="4"

inherit toolchain-funcs

DESCRIPTION="Userland client/server for kernel network block device"
HOMEPAGE="http://nbd.sourceforge.net/"
SRC_URI="mirror://sourceforge/nbd/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm ppc ppc64 x86"
IUSE="debug zlib"

RDEPEND=">=dev-libs/glib-2.0
	zlib? ( sys-libs/zlib )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_configure() {
	econf \
		--enable-lfs \
		--enable-syslog \
		$(use_enable debug)
}

src_compile() {
	default
	use zlib && emake -C gznbd CC="$(tc-getCC)"
}

src_install() {
	default
	use zlib && dobin gznbd/gznbd
}
