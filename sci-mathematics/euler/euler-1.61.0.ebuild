# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/euler/euler-1.61.0.ebuild,v 1.4 2006/10/17 22:44:41 wolf31o2 Exp $

inherit autotools eutils

DESCRIPTION="Mathematical programming environment"
HOMEPAGE="http://euler.sourceforge.net/"
SRC_URI="mirror://sourceforge/euler/${P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc -sparc x86"
IUSE=""
DEPEND=">=x11-libs/gtk+-2"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/configure-gentoo.patch
	epatch "${FILESDIR}"/command-gcc4-gentoo.patch
	epatch "${FILESDIR}"/euler-glibc-2.4-gentoo.patch
	eautoreconf

	sed -e 's:g77:g77 gfortran:g' -i ./configure || \
		die "Failed to patch configure"
}


src_install() {
	make DESTDIR="${D}" install || die "install failed"
}
