# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/glchess/glchess-0.9.12.ebuild,v 1.1 2006/10/19 02:25:31 mr_bones_ Exp $

inherit distutils games

DESCRIPTION="A 3D OpenGL based chess game"
HOMEPAGE="http://glchess.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="nls"

DEPEND="dev-python/pygtkglext
	dev-python/imaging
	sys-apps/dbus"

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
	distutils_src_install
	if use nls ; then
		emake DESTDIR="${D}" install || die "emake install failed"
	fi
	dogamesbin "build/scripts-2.4/glchess" || die "installing the binary failed"
	rm -rf ${D}usr/bin
	rm -rf "${D}"usr/bin "${D}"usr/share/doc/${PF}/{MANIFEST.in,PKG-INFO}.gz
	mv "${D}"usr/share/games/${PN} "${D}${GAMES_DATADIR}"
	prepgamesdirs
}
