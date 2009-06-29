# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/rb_libtorrent/rb_libtorrent-0.13-r1.ebuild,v 1.2 2009/06/29 00:06:04 yngwin Exp $

EAPI="2"
inherit eutils flag-o-matic

RESTRICT="test"  # tests break due to the CVE patch :(
MY_P=${P/rb_/}
S=${WORKDIR}/${MY_P}

DESCRIPTION="A C++ BitTorrent implementation focusing on efficiency and scalability"
HOMEPAGE="http://www.rasterbar.com/products/libtorrent/"
SRC_URI="mirror://sourceforge/libtorrent/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE="debug doc"

DEPEND="|| ( >=dev-libs/boost-1.34.1
		~dev-libs/boost-1.33.1[threads] )
	!net-libs/libtorrent"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-CVE-2009-1760.patch  # bug 273156
	epatch "${FILESDIR}"/${P}-boost-1.37.patch     # bug 270447
	epatch "${FILESDIR}"/${P}-gcc44.patch
}

src_configure() {
	append-ldflags -pthread

	# fails with as-needed, bug 271818
	append-ldflags -Wl,--no-as-needed

	# use multi-threaded boost libs
	local BOOST_LIBS="--with-boost-date-time=boost_date_time-mt \
		--with-boost-filesystem=boost_filesystem-mt \
		--with-boost-thread=boost_thread-mt \
		--with-boost-regex=boost_regex-mt \
		--with-boost-program_options=boost_program_options-mt"

	econf $(use_enable debug) ${BOOST_LIBS}
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc ChangeLog AUTHORS NEWS README || die "dodoc failed"
	if use doc ; then
		dohtml docs/* || die "Could not install HTML documentation"
	fi
}
