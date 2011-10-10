# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-server/crossfire-server/crossfire-server-1.11.0.ebuild,v 1.8 2011/10/10 14:40:21 tupone Exp $

EAPI=2
inherit eutils autotools games

MY_P="${P/-server/}"
DESCRIPTION="server for the crossfire clients"
HOMEPAGE="http://crossfire.real-time.com/"
SRC_URI="mirror://sourceforge/crossfire/${MY_P}.tar.gz
	mirror://sourceforge/crossfire/crossfire-${PV}.maps.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE="X"

DEPEND="
	net-misc/curl
	X? (
		x11-libs/libXaw
		media-libs/libpng )"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${FILESDIR}"/${P}-libpng15.patch \
		"${FILESDIR}"/${P}-curl.patch
	sed -i \
		-e 's/make /$(MAKE) /' \
		$(find . -name Makefile.am) \
		|| die 'sed failed'
	sed -i \
		-e '/,2.5/s/,2.5/,2.6,2.5/' \
		acinclude.m4 \
		|| die 'sed failed'
	rm -f "${WORKDIR}"/maps/Info/combine.pl # bug #236205
	eautoreconf
}

src_configure() {
	egamesconf \
		--disable-dependency-tracking \
		$(use_with X x)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	keepdir "${GAMES_STATEDIR}"/crossfire/{datafiles,maps,players,template-maps,unique-items}
	dodoc AUTHORS ChangeLog DEVELOPERS NEWS README TODO
	insinto "${GAMES_DATADIR}/crossfire"
	doins -r "${WORKDIR}/maps" || die "doins failed"
	prepgamesdirs
}
