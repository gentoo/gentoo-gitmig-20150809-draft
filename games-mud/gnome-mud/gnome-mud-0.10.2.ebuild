# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/gnome-mud/gnome-mud-0.10.2.ebuild,v 1.1 2003/09/10 19:03:12 vapier Exp $

inherit games

DESCRIPTION="GNOME MUD client"
SRC_URI="mirror://sourceforge/amcl/${P}.tar.gz"
HOMEPAGE="http://amcl.sourceforge.net/"

LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"

IUSE="nls"

DEPEND="virtual/glibc
	>=sys-apps/sed-4
	=x11-libs/gtk+-2*
	=gnome-base/libgnome-2*
	=gnome-base/libgnomeui-2*
	>=x11-libs/vte-0.10.26
	dev-python/pygtk
	nls? ( >=sys-devel/gettext-0.10.40 )"

src_unpack() {
	local editfile

	unpack ${A}

	if [ `use nls` ] ; then
		cd ${S}/src
		for editfile in modules.c prefs.c net.c init.c data.c ; do
			sed -i \
				-e 's|\(.*\)\(<libintl.h>\)|//\1\2|g' ${editfile} || \
					die "sed ${editfile}"
		done
	fi
}

src_compile() {
	econf `use_enable nls` || die
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR=${D} || die "make install failed"
	dodoc AUTHORS BUGS ChangeLog NEWS PLUGIN.API README ROADMAP

	[ `use nls` ] || rm -rf ${D}/usr/share/locale

	cd ${D}/usr/games
	dodir ${GAMES_BINDIR}
	mv gnome-mud ${D}/${GAMES_BINDIR}
	prepgamesdirs
}
