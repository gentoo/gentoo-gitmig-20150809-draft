# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: initial version by Ron Simpkin doobedoobedo@quake3world.com

inherit eutils games

DESCRIPTION="full featured educational application for children from 3 to 10"
HOMEPAGE="http://ofset.sourceforge.net/gcompris/"
SRC_URI="mirror://sourceforge/gcompris/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="oggvorbis nls python"

DEPEND="virtual/x11
	>=sys-apps/sed-4
	>=gnome-base/libgnome-1.96.0
	>=gnome-base/libgnomeui-1.96.0
	>=gnome-base/libgnomecanvas-2.0.2
	>=dev-libs/glib-2.0
	=x11-libs/gtk+-2*
	dev-libs/libassetml
	dev-libs/libxml2
	games-board/gnuchess
	sys-apps/texinfo
	app-text/texi2html
	python? ( dev-lang/python )
	oggvorbis? ( media-libs/libogg
			media-libs/libvorbis
			media-libs/libao )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-lang.patch
}

src_compile() {
	export GNUCHESS="${GAMES_BINDIR}/gnuchess"

	local myconf=""
	use oggvorbis && myconf="${myconf} --with-ogg=/usr --with-vorbis=/usr --with-ao=/usr"
	use python && myconf="${myconf} --with-python=`which python`"
#	egamesconf ${myconf} || die
#	for f in `grep -Rl /usr/games/share *` ; do
#		sed -i \
#			-e "s:${GAMES_PREFIX}/share/gnome:/usr/share/gnome:g" \
#			-e "s:${GAMES_PREFIX}/share:${GAMES_DATADIR}:g" \
#			${f} || die "sed ${f} failed"
#	done
	econf ${myconf} || die

	emake || die "emake failed"
}

src_install() {
	make install DESTDIR=${D} || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
#	mv ${D}/${GAMES_DATADIR}/{locale,gnome,pixmaps} ${D}/usr/share/
#	rm -rf ${D}/${GAMES_LIBDIR}/menu
#	if [ ! `use nls` ] ; then
#		rm -rf ${D}/usr/share/locale
#		cd ${D}/${GAMES_DATADIR}/gcompris/boards/sounds
#		rm -rf `find -type d -maxdepth 1 -mindepth 1 ! -name en`
#	fi
#	prepgamesdirs
}
