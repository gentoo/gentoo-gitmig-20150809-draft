# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/polylib/polylib-9999.ebuild,v 1.1 2008/09/21 08:46:58 vapier Exp $

EGIT_REPO_URI="git://repo.or.cz/polylib.git"
EGIT_BOOTSTRAP="eautoreconf && cd cln && eautoreconf"
inherit git autotools eutils

DESCRIPTION="ppl port of cloog"
HOMEPAGE="http://icps.u-strasbg.fr/polylib/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

src_unpack() {
	git_src_unpack
	cd "${S}"
	epatch "${FILESDIR}"/${P}-headers.patch
	# strip LDFLAGS from pkgconfig .pc file
	sed -i '/Libs:/s:@LDFLAGS@::' configure
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc doc/Changes
}
