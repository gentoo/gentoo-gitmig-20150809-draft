# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/multimon/multimon-1.0-r2.ebuild,v 1.2 2011/06/01 23:59:23 flameeyes Exp $

EAPI="2"

inherit eutils toolchain-funcs

S=${WORKDIR}/multimon
SRC_URI="http://www.baycom.org/~tom/ham/linux/multimon.tar.gz"
HOMEPAGE="http://www.baycom.org/~tom/ham/linux/multimon.html"
DESCRIPTION="Multimon decodes digital transmission codes using OSS"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~ppc ~x86"
IUSE=""

RDEPEND="x11-libs/libX11"

DEPEND="${RDEPEND}
	x11-proto/xproto"

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-flags.patch \
		"${FILESDIR}"/${P}-includes.patch
}

src_compile() {
	# bug #369713
	emake -j1 CFLAGS="${CFLAGS}" CC=$(tc-getCC) || die
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
