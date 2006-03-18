# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/upnp/upnp-1.2.1a.ebuild,v 1.6 2006/03/18 21:57:14 flameeyes Exp $

inherit eutils toolchain-funcs

MY_P="lib${P}"

DESCRIPTION="Intel's UPnP SDK"
HOMEPAGE="http://upnp.sourceforge.net"
SRC_URI="mirror://sourceforge/upnp/${MY_P}.tar.gz"
RESTRICT="nomirror"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="doc debug"

RDEPEND="sys-fs/e2fsprogs"

DEPEND="${RDEPEND}
	doc? ( app-doc/doc++
	       app-text/tetex
	       virtual/ghostscript )"

S="${WORKDIR}/${MY_P}/upnp"

src_unpack() {
	unpack ${A}
	cd ${S}/..

	epatch "${FILESDIR}/${MY_P}-gcc4.patch"
	epatch "${FILESDIR}/${MY_P}-fbsd.patch"
	epatch "${FILESDIR}/${MY_P}-respectflags.patch"
}

src_compile() {
	myconf=""

	if use debug; then
		myconf="DEBUG=1"
	fi

	# Fix for distcc/crosscompile, and make sure it doesn't strip
	emake ${myconf} \
		CC=$(tc-getCC) \
		AR=$(tc-getAR) \
		LD=$(tc-getLD) \
		STRIP=true \
		|| die "Compile failed!"

	if use doc; then
		emake doc || die "Documentation generation failed!"
	fi
}

src_install () {
	if use debug; then
		dolib.so bin/debug/libupnp.so
		dolib.so bin/debug/libixml.so
		dolib.so bin/debug/libthreadutil_dbg.so
	else
		dolib.so bin/libupnp.so
		dolib.so bin/libixml.so
		dolib.so bin/libthreadutil.so
	fi

	dodir /usr/include/upnp
	insinto /usr/include/upnp
	doins inc/*.h

	dodoc LICENSE ../README doc/UPnP_Programming_Guide.pdf
	if use doc; then
		dodoc doc/ixml.pdf doc/upnpsdk.pdf
		dohtml doc/html/*
	fi
}
