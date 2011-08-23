# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/lensfun/lensfun-0.2.5.ebuild,v 1.2 2011/08/23 23:00:46 radhermit Exp $

EAPI=2

DESCRIPTION="lensfun: A library for rectifying and simulating photographic lens
distortions"
HOMEPAGE="http://lensfun.berlios.de/"
SRC_URI="mirror://berlios/lensfun/${P}.tar.bz2"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ppc ~ppc64 ~x86"
IUSE="debug doc"

RDEPEND="
	>=dev-libs/glib-2.0
	>=media-libs/libpng-1.0"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( >=app-doc/doxygen-1.5.0 )"

src_prepare() {
	# disable stripping, remove ricer CFLAGS
	sed -i \
		-e 's:-s -O3 -fomit-frame-pointer -funroll-loops::g' \
		-e 's:GCC.LDFLAGS.release = -s:GCC.LDFLAGS.release =:g' \
		build/tibs/compiler/gcc.mak || die
}

src_configure() {
	local myconf=""
	use debug && myconf="--mode=debug"
	# econf does NOT work
	./configure --prefix=/usr ${myconf} || die
}

src_compile() {
	emake all V=1 || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	# TODO remove docs if ! use doc
}
