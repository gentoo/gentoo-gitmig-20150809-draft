# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/rb_libtorrent/rb_libtorrent-0.14.4.ebuild,v 1.1 2009/06/06 16:30:06 armin76 Exp $

inherit eutils autotools

MY_P=${P/rb_/}
MY_P=${MY_P/torrent/torrent-rasterbar}
S=${WORKDIR}/${MY_P}

DESCRIPTION="BitTorrent library written in C++ for *nix."
HOMEPAGE="http://www.rasterbar.com/products/libtorrent/"
SRC_URI="mirror://sourceforge/libtorrent/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"

IUSE="debug examples python test"

DEPEND="
	>=dev-libs/boost-1.34
	|| ( >=dev-libs/boost-1.35 dev-cpp/asio )
	sys-libs/zlib
	!net-libs/libtorrent"
RDEPEND="${DEPEND}"

src_compile() {
	#use multi-threading versions of boost libs
	local BOOST_LIBS="
		--with-boost-system=boost_system-mt \
		--with-boost-asio=boost_system-mt \
		--with-boost-filesystem=boost_filesystem-mt \
		--with-boost-thread=boost_thread-mt \
		--with-boost-regex=boost_regex-mt \
		--with-boost-python=boost_python-mt \
		--with-boost-program_options=boost_program_options-mt"

	#TODO: We might want to add 'use debug -> --with-logging=verbose
	econf \
		$(use_enable debug) \
		$(use_enable test tests) \
		$(use_enable examples) \
		$(use_enable python python-binding) \
		--with-zlib=system \
		--with-asio=system \
		${BOOST_LIBS} \
		LDFLAGS="${LDFLAGS} -pthread" || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc ChangeLog AUTHORS NEWS README
}
