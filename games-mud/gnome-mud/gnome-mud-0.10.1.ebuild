# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/gnome-mud/gnome-mud-0.10.1.ebuild,v 1.1 2003/09/10 19:03:12 vapier Exp $

inherit games

DESCRIPTION="GNOME MUD client"
SRC_URI="mirror://sourceforge/amcl/${P}.tar.gz"
HOMEPAGE="http://amcl.sourceforge.net/"

KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"
IUSE="nls"

DEPEND="virtual/glibc
	=x11-libs/gtk+-2*
	=gnome-base/libgnome-2*
	=gnome-base/libgnomeui-2*
	>=x11-libs/vte-0.10.26
	dev-python/pygtk
	nls? ( >=sys-devel/gettext-0.10.40 )"

src_unpack() {
	unpack ${A}

	if [ `use nls` ] ; then
		cd ${S}/src
		for editfile in modules.c prefs.c net.c init.c data.c ; do
			cp ${editfile} ${editfile}.orig
			sed 's|\(.*\)\(<libintl.h>\)|//\1\2|g' ${editfile}.orig > ${editfile}
		done
	fi
}

src_compile() {
	econf `use_enable nls` || die
	emake || die
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc AUTHORS COPYING* ChangeLog NEWS README*

	[ `use nls` ] || rm -rf ${D}/usr/share/locale

	cd ${D}/usr/games
	dodir ${GAMES_BINDIR}
	mv gnome-mud ${D}/${GAMES_BINDIR}
	prepgamesdirs
}
