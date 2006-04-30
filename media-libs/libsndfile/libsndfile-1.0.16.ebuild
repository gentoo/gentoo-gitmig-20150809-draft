# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libsndfile/libsndfile-1.0.16.ebuild,v 1.2 2006/04/30 18:46:49 flameeyes Exp $

inherit eutils libtool

DESCRIPTION="A C library for reading and writing files containing sampled sound"
HOMEPAGE="http://www.mega-nerd.com/libsndfile/"
SRC_URI="http://www.mega-nerd.com/libsndfile/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86"
IUSE="static sqlite flac alsa"
RESTRICT="test"

RDEPEND="flac? ( media-libs/flac )
	alsa? ( media-libs/alsa-lib )
	sqlite? ( >=dev-db/sqlite-3.2 )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epunt_cxx
}

src_compile() {
	econf \
		$(use_enable sqlite) \
		$(use_enable static) \
		$(use_enable flac) \
		$(use_enable alsa) \
		--disable-werror \
		--disable-gcc-pipe \
		--disable-dependency-tracking \
		|| die "econf failed"

	# fix this weird doc installation directory libsndfile decides
	# to something more standard
	sed -e "s:^htmldocdir.*:htmldocdir = /usr/share/doc/${PF}/html:" -i ${S}/doc/Makefile

	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO || die "dodoc failed"
}
