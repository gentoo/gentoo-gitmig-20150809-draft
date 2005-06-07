# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/upnp/upnp-1.2.1a.ebuild,v 1.1 2005/06/07 08:54:02 dragonheart Exp $

inherit eutils

S="${WORKDIR}/${PN}sdk-${PV}"

DESCRIPTION="Intel's UPnP SDK"
HOMEPAGE="http://upnp.sourceforge.net"
SRC_URI="mirror://sourceforge/upnp/lib${PN}-${PV}.tar.gz"
RESTRICT="nomirror"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc debug"

DEPEND="sys-fs/e2fsprogs
	doc? ( app-doc/doc++
	       app-text/tetex
	       app-text/ghostscript )"

S=${WORKDIR}/lib${PN}-${PV}/upnp

src_compile() {
	myconf=""

	if use debug; then
		myconf="DEBUG=1"
	fi

	cd ${S} &&
	emake ${myconf} || die "Compile failed!"

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
