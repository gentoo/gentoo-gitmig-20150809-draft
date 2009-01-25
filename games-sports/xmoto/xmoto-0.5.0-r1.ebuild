# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-sports/xmoto/xmoto-0.5.0-r1.ebuild,v 1.3 2009/01/25 00:25:53 mr_bones_ Exp $

EAPI=2
inherit autotools eutils games

LVL_PV="0.5.0~rc2" #they unfortunately don't release both at the same time, why ~ as separator :(
LVL="inksmoto-${LVL_PV}"
DESCRIPTION="A challenging 2D motocross platform game"
HOMEPAGE="http://xmoto.tuxfamily.org"
SRC_URI="http://download.tuxfamily.org/${PN}/${PN}/${PV}/${P}-src.tar.gz
	editor? ( http://download.tuxfamily.org/xmoto/svg2lvl/${LVL_PV}/${LVL}.tar.gz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="editor nls"

RDEPEND="
	dev-db/sqlite:3
	dev-games/ode
	dev-lang/lua[deprecated]
	media-libs/jpeg
	media-libs/libpng
	media-libs/libsdl[joystick]
	media-libs/sdl-mixer[vorbis]
	media-libs/sdl-ttf
	media-libs/sdl-net
	net-misc/curl
	app-arch/bzip2
	virtual/opengl
	virtual/glu
	nls? ( virtual/libintl )
	editor? ( media-gfx/inkscape )"
DEPEND="${RDEPEND}
	!=dev-db/sqlite-3.6.2
	nls? ( sys-devel/gettext )"

src_prepare() {
	use editor && rm -f "${WORKDIR}"/extensions/{bezmisc,inkex}.py
	sed -i \
		-e '/^gettextsrcdir/s:=.*:= @localedir@/gettext/po:' \
		po/Makefile.in.in \
		|| die "sed failed"
}

src_configure() {
	egamesconf \
		--disable-dependency-tracking \
		--with-enable-zoom=1 \
		--enable-threads=posix \
		--with-gnu-ld \
		$(use_enable nls) \
		--localedir=/usr/share/locale \
		--with-localesdir=/usr/share/locale \
		--with-renderer-sdlGfx=0 \
		--with-renderer-openGl=1
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README TODO NEWS ChangeLog

	doicon extra/xmoto.xpm
	make_desktop_entry ${PN} Xmoto

	prepgamesdirs

	if use editor; then
		insinto /usr/share/inkscape/
		doins -r "${WORKDIR}"/extensions/ || die "doins failed"
	fi
}

pkg_postinst() {
	games_pkg_postinst
	if use editor; then
		elog "If you want to know how to create Xmoto levels"
		elog "have a look at this Tutorial:"
		elog "http://wiki.xmoto.tuxfamily.org/index.php?title=Inkscape-0.5.0"
		elog "You can share your levels on the Xmoto homepage."
	fi
}
