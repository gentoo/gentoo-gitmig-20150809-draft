# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/rb_libtorrent/rb_libtorrent-0.14.12.ebuild,v 1.1 2010/09/08 23:03:43 hwoarang Exp $

EAPI="2"
inherit autotools eutils flag-o-matic versionator

MY_P=${P/rb_/}
MY_P=${MY_P/torrent/torrent-rasterbar}
S=${WORKDIR}/${MY_P}

DESCRIPTION="C++ BitTorrent implementation focusing on efficiency and scalability"
HOMEPAGE="http://www.rasterbar.com/products/libtorrent/"
SRC_URI="http://libtorrent.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE="debug doc examples python test"
RESTRICT="test"

DEPEND="|| ( >=dev-libs/boost-1.35
		( ~dev-libs/boost-1.34.1 dev-cpp/asio ) )
	python? ( >=dev-libs/boost-1.35.0-r5[python] dev-lang/python:2.6[threads] )
	=sys-devel/libtool-2.2*
	sys-libs/zlib
	examples? ( !net-p2p/mldonkey )"  #292998
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.14.9-as-needed-fix.patch  #276873
	epatch "${FILESDIR}"/${PN}-0.14.8-boost-detect.patch   #295474
	rm ltmain.sh  #298069
	eautoreconf
}

src_configure() {
	append-ldflags -pthread

	# use multi-threading versions of boost libs
	local BOOST_LIBS="--with-boost-system=boost_system-mt \
		--with-boost-asio=boost_system-mt \
		--with-boost-filesystem=boost_filesystem-mt \
		--with-boost-thread=boost_thread-mt \
		--with-boost-regex=boost_regex-mt \
		--with-boost-python=boost_python-mt \
		--with-boost-program_options=boost_program_options-mt"

	# detect boost version and location, bug 295474
	BOOST_PKG="$(best_version ">=dev-libs/boost-1.34.1")"
	BOOST_VER="$(get_version_component_range 1-2 "${BOOST_PKG/*boost-/}")"
	BOOST_VER="$(replace_all_version_separators _ "${BOOST_VER}")"
	BOOST_INC="/usr/include/boost-${BOOST_VER}"
	BOOST_LIB="/usr/$(get_libdir)/boost-${BOOST_VER}"

	local LOGGING
	use debug && LOGGING="--with-logging=verbose"

	econf $(use_enable debug) \
		$(use_enable test tests) \
		$(use_enable examples) \
		$(use_enable python python-binding) \
		--with-zlib=system \
		--with-asio=system \
		${LOGGING} \
		--with-boost=${BOOST_INC} \
		--with-boost-libdir=${BOOST_LIB} \
		${BOOST_LIBS}
}

src_install() {
	emake DESTDIR="${D}" install || die 'emake install failed'
	dodoc ChangeLog AUTHORS NEWS README || die 'dodoc failed'
	if use doc ; then
		dohtml docs/* || die "Could not install HTML documentation"
	fi
}
