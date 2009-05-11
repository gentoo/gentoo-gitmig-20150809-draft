# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nfdump/nfdump-1.5.8.ebuild,v 1.1 2009/05/11 16:12:38 pva Exp $

EAPI=2
inherit eutils

DESCRIPTION="A set of tools to collect and process netflow data"
HOMEPAGE="http://nfdump.sourceforge.net/"
SRC_URI="mirror://sourceforge/nfdump/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="sys-devel/flex"
RDEPEND="dev-lang/perl"

src_prepare() {
	epatch "${FILESDIR}/${P}-parallel.patch"
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS README || die
}
