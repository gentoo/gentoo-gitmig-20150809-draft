# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/glame/glame-1.0.1.ebuild,v 1.4 2004/01/21 18:42:53 raker Exp $

IUSE="nls gnome"

S=${WORKDIR}/${P}
DESCRIPTION="Glame is an audio file editing utility"
SRC_URI="mirror://sourceforge/glame/${P}.tar.gz"
HOMEPAGE="http://glame.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc"

DEPEND=">=dev-util/guile-1.4-r3
	dev-libs/libxml2
	>=media-sound/esound-0.2
	media-libs/audiofile
	media-sound/mad
	oggvorbis? ( media-sound/vorbis-tools )
	gnome? ( <gnome-base/libglade-2 gnome-base/gnome-libs )"

RDEPEND="nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}

	# fix NLS problem (bug #7587)
	if [ ! "`use nls`" ]
	then
		cd ${S}/src/gui
		mv swapfilegui.c swapfilegui.c.bad
		sed -e "s:#include <libintl.h>::" swapfilegui.c.bad > swapfilegui.c
	fi

	# fix makefile problem
	export WANT_AUTOCONF_2_5=1
	cd ${S}/libltdl
	autoconf -f
}

src_compile() {
	local myconf=""

	if [ "`use gnome`" ]
	then
		# Use a valid icon for the GNOME menu entry
		cp src/gui/glame.desktop src/gui/glame.desktop.old
		sed -e 's:glame.png:glame-logo.jpg:' \
			src/gui/glame.desktop.old > src/gui/glame.desktop
		rm src/gui/glame.desktop.old
	fi

	use nls	&& myconf="--enable-nls" \
		|| myconf="--disable-nls"
	use gnome && myconf="${myconf} --enable-gui" \
		|| myconf="${myconf} --disable-gui"

	econf --with-included-gettext ${myconf} || die "Configuration failed"
	emake || die "Compilation failed"
}

src_install () {
	einstall || die "Installation failed"

	if [ "`use gnome`" ]
	then
		dodir /usr/share/pixmaps
		dosym ../glame/pixmaps/glame-logo.jpg \
		      /usr/share/pixmaps/glame-logo.jpg
	fi

	dodoc ABOUT-NLS AUTHORS BUGS COPYING CREDITS ChangeLog MAINTAINERS \
		NEWS README TODO
}

