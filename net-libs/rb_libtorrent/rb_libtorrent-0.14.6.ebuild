# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/rb_libtorrent/rb_libtorrent-0.14.6.ebuild,v 1.5 2009/12/17 20:10:53 maekke Exp $

EAPI="2"
inherit autotools eutils flag-o-matic

MY_P=${P/rb_/}
MY_P=${MY_P/torrent/torrent-rasterbar}
S=${WORKDIR}/${MY_P}

DESCRIPTION="C++ BitTorrent implementation focusing on efficiency and scalability"
HOMEPAGE="http://www.rasterbar.com/products/libtorrent/"
SRC_URI="mirror://sourceforge/libtorrent/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~ppc ~ppc64 x86 ~x86-fbsd"
IUSE="debug doc examples python test"
# remove this restrict in next version!
RESTRICT="test"

DEPEND="!net-libs/libtorrent
	|| ( >=dev-libs/boost-1.35
		( ~dev-libs/boost-1.34.1 dev-cpp/asio ) )
	python? ( || ( >=dev-libs/boost-1.35.0-r5[python]
		=dev-libs/boost-1.35.0-r2 ) )
	sys-libs/zlib"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/0.14.6-configure-ldflags-fix.patch  #290756
	eautoreconf
}

src_configure() {
	append-ldflags -pthread

	#use multi-threading versions of boost libs
	local BOOST_LIBS="--with-boost-system=boost_system-mt \
		--with-boost-asio=boost_system-mt \
		--with-boost-filesystem=boost_filesystem-mt \
		--with-boost-thread=boost_thread-mt \
		--with-boost-regex=boost_regex-mt \
		--with-boost-python=boost_python-mt \
		--with-boost-program_options=boost_program_options-mt"

	local LOGGING
	use debug && LOGGING="--with-logging=verbose"

	econf $(use_enable debug) \
		$(use_enable test tests) \
		$(use_enable examples) \
		$(use_enable python python-binding) \
		--with-zlib=system \
		--with-asio=system \
		${LOGGING} \
		${BOOST_LIBS}
}

src_install() {
	emake DESTDIR="${D}" install || die 'emake install failed'
	dodoc ChangeLog AUTHORS NEWS README || die 'dodoc failed'
	if use doc ; then
		dohtml docs/* || die "Could not install HTML documentation"
	fi
}
