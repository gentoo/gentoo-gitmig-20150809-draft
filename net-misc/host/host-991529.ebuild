# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: George Shapovalov <george@gentoo.org>
# /space/gentoo/cvsroot/gentoo-x86/skel.ebuild,v 1.4 2002/03/12 16:05:09 tod Exp

S="${WORKDIR}"

DESCRIPTION="the standalone host tool, supports LOC reporting (RFC1876)"
#this is somewhat old tool, has not been changed since 1999,
#still looks like host from bind does not provide all possible functionality
#at least xtraceroute wants LOC support, which is provided by this tool

SRC_URI="ftp://ftp.ripe.net/tools/dns/${PN}.tar.Z"
HOMEPAGE="http://www.dtek.chalmers.se/~d3august/xt/"
#that's the homepage for xtraceroute, not host, but that's best I can do
#at least it is mentioned there

DEPEND="x11-base/xfree
	x11-libs/gtk+
	net-misc/traceroute
	x11-libs/gtkglarea
	media-libs/gdk-pixbuf
	net-misc/host"

RDEPEND="${DEPEND}"

src_unpack() {
	cd ${S}
	unpack "${PN}.tar.Z"

	mv Makefile Makefile-orig
	sed -e "s:staff:root:" Makefile-orig > Makefile
}

src_compile() {
	make || die
}

src_install () {
	#ATTN!!
	#This util has slightly different format of output
	#I will make it to install into /usr/local (both tool and man page)
	#to let it coexist with host from bind
	export DESTTREE=/usr/local/
	dobin host
	doman host.1
}
