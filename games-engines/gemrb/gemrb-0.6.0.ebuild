# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-engines/gemrb/gemrb-0.6.0.ebuild,v 1.1 2009/12/16 05:12:04 mr_bones_ Exp $

EAPI=2
inherit autotools eutils games

DESCRIPTION="Reimplementation of the Infinity engine"
HOMEPAGE="http://gemrb.sourceforge.net/"
SRC_URI="mirror://sourceforge/gemrb/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND=">=media-libs/libsdl-1.2
	sys-libs/zlib
	media-libs/libvorbis
	media-libs/libpng
	media-libs/openal
	>=dev-lang/python-2.3"

src_prepare() {
	sed -i \
		-e 's|\$(bindir)/plugins/|\$(libdir)/|' \
		Makefile.am \
		|| die "sed failed"
	sed -i \
		-e '/NullSound/d' \
		gemrb/plugins/Makefile.am \
		|| die "sed failed"
	sed -i \
		-e '/sysconf_DATA = /d' \
		gemrb/Makefile.am \
		|| die "sed failed"
	eautoreconf
}

src_configure() {
	egamesconf \
		--disable-dependency-tracking \
		--docdir="/usr/share/doc/${PF}"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	diropts -m0775 -g ${GAMES_GROUP}
	keepdir "/var/cache/gemrb"
	dodoc "${FILESDIR}/GemRB.cfg.sample" README AUTHORS
	prepalldocs
	prepgamesdirs
}
