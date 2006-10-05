# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/daemonshogi/daemonshogi-0.1.3.ebuild,v 1.9 2006/10/05 17:24:04 nyhm Exp $

AT_M4DIR=macros
WANT_AUTOMAKE=latest
inherit autotools eutils games

DESCRIPTION="A GTK+ based, simple shogi (Japanese chess) program"
HOMEPAGE="http://daemonshogi.sourceforge.jp"
SRC_URI="http://daemonshogi.sourceforge.jp/old_version/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2"
KEYWORDS="~amd64 ppc sparc x86"
SLOT="0"
IUSE="nls"

RDEPEND="gnome-base/gnome-libs
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	nls? ( >=sys-devel/gettext-0.10.38 )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	rmdir pixmaps
	epatch "${FILESDIR}/${P}"-sandbox.patch
	sed -i \
		-e "/^localedir/s:\$(datadir):/usr/share:" \
		-e "/^gnulocaledir/s:\$(prefix):/usr:" \
		po/Makefile.in.in \
		|| die "sed failed"
	sed -i \
		-e '/PACKAGE_LOCALE_DIR/s:".*":"/usr/share/locale":' \
		configure.in \
		|| die "sed failed"
	eautoreconf
}

src_compile() {
	if use nls && has_version '>=sys-devel/gettext-0.12' ; then
		export XGETTEXT="/usr/bin/xgettext --from-code=EUC-JP"
	fi
	egamesconf $(use_enable nls) || die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc ChangeLog README* NEWS
	prepgamesdirs
}
