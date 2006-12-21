# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/upnp/upnp-1.3.1.ebuild,v 1.6 2006/12/21 15:46:57 corsair Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Intel's UPnP SDK"
HOMEPAGE="http://upnp.sourceforge.net"
SRC_URI="mirror://sourceforge/upnp/lib${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ppc ppc64 sparc x86"
IUSE="doc debug"

RDEPEND="sys-fs/e2fsprogs"
DEPEND="${RDEPEND}
	!net-misc/libupnp
	doc? ( app-doc/doc++
	       virtual/tetex
	       virtual/ghostscript )"

S=${WORKDIR}/lib${P}

src_compile() {
	econf \
		$(use_enable debug) \
		|| die "econf failed"

	# Fix for distcc/crosscompile, and make sure it doesn't strip
	emake \
		CC=$(tc-getCC) \
		AR=$(tc-getAR) \
		LD=$(tc-getLD) \
		STRIP=true \
		|| die "emake failed"

	if use doc; then
		emake html pdf || die "emake html pdf failed"
	fi
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc README LICENSE NEWS
	dodoc ixml/doc/*
	dodoc upnp/doc/*
}

