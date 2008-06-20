# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/libpar2/libpar2-0.2.ebuild,v 1.6 2008/06/20 10:47:16 yngwin Exp $

EAPI=1

DESCRIPTION="A library for par2, extracted from par2cmdline"
HOMEPAGE="http://parchive.sourceforge.net/"
SRC_URI="mirror://sourceforge/parchive/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc x86"
IUSE=""

RDEPEND="dev-libs/libsigc++:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	make install DESTDIR="${D}" || die "make install failed"
	dodoc AUTHORS ChangeLog README
}
