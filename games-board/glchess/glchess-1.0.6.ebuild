# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/glchess/glchess-1.0.6.ebuild,v 1.1 2007/08/25 19:13:24 tupone Exp $

inherit python distutils games

DESCRIPTION="A 3D OpenGL based chess game"
HOMEPAGE="http://glchess.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls"

DEPEND="!>=gnome-extra/gnome-games-2.18
	dev-python/pygtkglext
	dev-python/imaging"

DOCS="BUGS"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "/_DIR/s:/usr/share/games:${GAMES_DATADIR}:" \
		lib/glchess/gtkui/{dialogs,gtkui}.py \
		lib/glchess/scene/opengl/{builtin_models,new_models,opengl}.py \
		|| die "sed failed"
}

src_install() {
	python_version
	distutils_src_install --install-scripts=${GAMES_BINDIR}
	if use nls ; then
		emake DESTDIR="${D}" install || die "emake install failed"
	fi
	rm -f "${D}"usr/share/doc/${PF}/{MANIFEST.in,PKG-INFO}.gz
	prepgamesdirs
}
