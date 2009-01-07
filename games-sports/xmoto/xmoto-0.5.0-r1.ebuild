# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-sports/xmoto/xmoto-0.5.0-r1.ebuild,v 1.1 2009/01/07 17:59:07 scarabeus Exp $

EAPI="2"

inherit eutils games

LVL_PV="0.5.0~rc1" #they unfortunately don't release both at the same time, why ~ as separator :(
LVL="inksmoto-${LVL_PV}"
DESCRIPTION="A challenging 2D motocross platform game"
HOMEPAGE="http://xmoto.tuxfamily.org"
SRC_URI="http://download.tuxfamily.org/${PN}/${PN}/${PV}/${P}-src.tar.gz
	editor? ( http://download.tuxfamily.org/xmoto/svg2lvl/${LVL_PV}/${LVL}.tar.gz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="X editor nls" # sdl"

RDEPEND="
	dev-db/sqlite:3
	dev-games/ode
	dev-lang/lua[deprecated]
	media-libs/jpeg
	media-libs/libpng
	media-libs/libsdl
	media-libs/sdl-mixer
	media-libs/sdl-ttf
	media-libs/sdl-net
	net-misc/curl
	virtual/opengl
	virtual/glu
	nls? ( virtual/libintl )
	editor? ( media-gfx/inkscape )
	"
DEPEND="${RDEPEND}
	!=dev-db/sqlite-3.6.2
	nls? ( sys-devel/gettext )
	"

src_prepare() {
	use editor && rm -f "${WORKDIR}"/extensions/{bezmisc,inkex}.py
}

src_configure() {
	#if use sdl ; then
	#	ewarn "SDL is known to be broken, if you experience any troubles please"
	#	ewarn "try again without this useflag"
	#	RENDERER="--with-renderer-sdlGfx=1 --with-renderer-openGl=0"
	#else
		RENDERER="--with-renderer-sdlGfx=0 --with-renderer-openGl=1"
	#fi
	if ! use nls ; then
		NLS="--disable-nls"
	else
		NLS="--with-gettext"
	fi
	# using some nice dejavu font, better than nothing
	egamesconf \
		--disable-dependency-tracking \
		--with-enable-zoom=1 \
		--enable-threads=posix \
		--with-gnu-ld \
		$(use_with X) \
		--with-localesdir=/usr/share/locale \
		${RENDERER} \
		${NLS}
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	## if it is not working nice way, we'll do it ugly way
	if use nls ; then
		dodir /usr/share/locale

		cd "${S}"/po
		for i in `ls -c1 |grep "\.gmo$"` ; do
			BASE=$(echo ${i} |sed 's/\.gmo$//g')
			msgfmt -v -o ${BASE}.mo ${BASE}.po

			insinto /usr/share/locale/${BASE}/LC_MESSAGES
			newins ${BASE}.gmo xmoto.mo
		done;
	fi
	cd "${S}"
	dodoc README TODO NEWS ChangeLog

	doicon extra/xmoto.xpm
	domenu extra/xmoto.desktop

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
