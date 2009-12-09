# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/kildclient/kildclient-2.9.0.ebuild,v 1.2 2009/12/09 22:36:33 fauli Exp $

EAPI=2
inherit autotools games

DESCRIPTION="Powerful MUD client with a built-in PERL interpreter"
HOMEPAGE="http://kildclient.sourceforge.net"
SRC_URI="mirror://sourceforge/kildclient/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="x86"
IUSE="doc gnutls spell"

RDEPEND="x11-libs/gtk+:2
	gnome-base/libglade
	dev-lang/perl
	virtual/libintl
	spell? ( app-text/gtkspell )
	gnutls? ( net-libs/gnutls )"
DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gentoo.patch
	eautoreconf
}

src_configure() {
	egamesconf \
		--disable-dependency-tracking \
		--localedir=/usr/share/locale \
		--docdir=/usr/share/doc/${PF} \
		--htmldir=/usr/share/doc/${PF}/html \
		$(use_with spell gtkspell) \
		$(use_with gnutls libgnutls) \
		$(use_with doc docs)
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS ChangeLog NEWS README
	prepgamesdirs
}
