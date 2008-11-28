# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/netdude/netdude-0.4.8a.ebuild,v 1.2 2008/11/28 18:38:33 gmsoft Exp $

DESCRIPTION="Netdude is a front-end to the libnetdude packet manipulation library"
HOMEPAGE="http://netdude.sourceforge.net/index.html"
SRC_URI="mirror://sourceforge/netdude/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc"

DEPEND=">=net-libs/libnetdude-0.10a
	=x11-libs/gtk+-1*
	virtual/fam"

RDEPEND="${DEPEND}
	net-analyzer/tcpdump
	>=x11-libs/libX11-1.0.0
	>=x11-libs/libXext-1.0.0"

src_compile() {
	econf $(use_enable doc gtk-doc) || die "econf failed"
	emake -j1 || die "emake failed"
}

src_install() {
	einstall || die "emake install failed"

	use doc || rm -rf "${D}"/usr/share/gtk-doc
}
