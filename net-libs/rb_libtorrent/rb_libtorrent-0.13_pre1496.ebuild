# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/rb_libtorrent/rb_libtorrent-0.13_pre1496.ebuild,v 1.1 2007/08/24 15:24:58 armin76 Exp $

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="latest"
inherit eutils autotools

MY_P="${P/rb_/}"

DESCRIPTION="BitTorrent library written in C++ for *nix."
HOMEPAGE="http://www.rasterbar.com/products/libtorrent/"
SRC_URI="mirror://gentoo/${MY_P}.tar.bz2"
S="${WORKDIR}/${MY_P}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
IUSE="debug"

DEPEND="dev-libs/boost
	!net-libs/libtorrent"
RDEPEND="${DEPEND}"

pkg_setup() {
	# We need boost built with threads
	if ! has_version ">=dev-libs/boost-1.34_pre20061214" && \
		! built_with_use "dev-libs/boost" threads; then
		eerror "${PN} needs dev-libs/boost built with threads USE flag"
		die "dev-libs/boost is built without threads USE flag"
	fi
}

src_compile() {
	BOOST_LIBS="--with-boost-date-time=boost_date_time-mt \
			--with-boost-filesystem=boost_filesystem-mt \
			--with-boost-thread=boost_thread-mt \
			--with-boost-regex=boost_regex-mt \
			--with-boost-program_options=boost_program_options-mt"

	AT_M4DIR="m4" eautoreconf

	econf $(use_enable debug) \
		 ${BOOST_LIBS} \
		 LDFLAGS="${LDFLAGS} -pthread" || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc ChangeLog AUTHORS NEWS README
}
