# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libdvdread/libdvdread-0.9.6.ebuild,v 1.18 2009/08/21 20:22:48 ssuominen Exp $

inherit autotools eutils

DESCRIPTION="Provides a simple foundation for reading DVD-Video images."
SRC_URI="http://www.dtek.chalmers.se/groups/dvd/dist/${P}.tar.gz"
HOMEPAGE="http://www.dtek.chalmers.se/groups/dvd/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc x86"
IUSE=""

RDEPEND=">=media-libs/libdvdcss-1.1.1"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-udfsymbols.patch"
	eautoreconf
}

src_compile() {
	local myconf=""
	econf ${myconf} || die "./configure failed"
	emake || die "make failed"
}

src_install() {
	einstall || die "make install failed"

	dobin src/.libs/*  # install executables
	cd "${D}"/usr/bin
	mv ./ifo_dump ./ifo_dump_dvdread

	cd "${S}"
	dodoc AUTHORS ChangeLog NEWS README TODO
}
