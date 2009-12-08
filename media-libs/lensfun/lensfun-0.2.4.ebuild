# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/lensfun/lensfun-0.2.4.ebuild,v 1.3 2009/12/08 16:37:52 ranger Exp $

inherit eutils

DESCRIPTION="lensfun: A library for rectifying and simulating photographic lens
distortions"
HOMEPAGE="http://lensfun.berlios.de/"
SRC_URI="mirror://berlios/lensfun/${P}.tar.bz2"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ppc ppc64 ~x86"
IUSE="debug doc"

RDEPEND="
	>=dev-libs/glib-2.0
	>=media-libs/libpng-1.0"
DEPEND="${RDEPEND}
	doc? ( >=app-doc/doxygen-1.5.0 )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-0.2.3-as-needed.patch
	epatch "${FILESDIR}"/${PN}-0.2.3-glibc-2.10.patch

	# disable stripping, remove ricer CFLAGS
	sed -i \
		-e 's:-s -O3 -fomit-frame-pointer -funroll-loops::g' \
		-e 's:GCC.LDFLAGS.release = -s:GCC.LDFLAGS.release =:g' \
		build/mak/compiler/gcc.mak
}

src_compile() {
	local myconf=""
	use debug && myconf="--mode=debug"
	# econf does NOT work
	./configure --prefix=/usr ${myconf} || die
	emake all V=1 || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	# TODO remove docs if ! use doc
}
