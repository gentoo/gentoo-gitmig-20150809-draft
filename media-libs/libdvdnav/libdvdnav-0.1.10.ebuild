# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libdvdnav/libdvdnav-0.1.10.ebuild,v 1.19 2008/08/08 15:03:28 aballier Exp $

inherit eutils base autotools

DESCRIPTION="Library for DVD navigation tools"
HOMEPAGE="http://sourceforge.net/projects/dvd/"
SRC_URI="mirror://sourceforge/dvd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="media-libs/libdvdread"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}"/${P}-build.patch
	"${FILESDIR}"/${P}-dontbuild-examples.patch
)

src_unpack() {
	base_src_unpack
	cd "${S}"

	eautoreconf
}

src_compile() {
	econf \
		--disable-examples \
		--disable-dependency-tracking \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install () {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS NEWS README
}
