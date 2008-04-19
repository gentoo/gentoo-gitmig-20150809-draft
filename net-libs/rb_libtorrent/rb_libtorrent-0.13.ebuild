# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/rb_libtorrent/rb_libtorrent-0.13.ebuild,v 1.2 2008/04/19 17:09:42 armin76 Exp $

inherit eutils autotools

MY_P=${P/rb_/}
S=${WORKDIR}/${MY_P}

DESCRIPTION="BitTorrent library written in C++ for *nix."
HOMEPAGE="http://www.rasterbar.com/products/libtorrent/"
SRC_URI="mirror://sourceforge/libtorrent/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"

IUSE="debug"

DEPEND="dev-libs/boost
	!net-libs/libtorrent"
RDEPEND="${DEPEND}"

pkg_setup() {
	# We need boost built with threads
	if ! built_with_use --missing true "dev-libs/boost" threads; then
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

	econf $(use_enable debug) \
		 ${BOOST_LIBS} \
		 LDFLAGS="${LDFLAGS} -pthread" || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc ChangeLog AUTHORS NEWS README
}
