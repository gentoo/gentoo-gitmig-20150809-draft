# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/ucl/ucl-1.03.ebuild,v 1.11 2011/01/13 20:54:18 ranger Exp $

EAPI="2"
inherit eutils

DESCRIPTION="the UCL Compression Library"
HOMEPAGE="http://www.oberhumer.com/opensource/ucl/"
SRC_URI="http://www.oberhumer.com/opensource/ucl/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

src_prepare() {
	epunt_cxx
}

src_configure() {
	econf --enable-shared || die
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc AUTHORS NEWS README THANKS TODO
}
