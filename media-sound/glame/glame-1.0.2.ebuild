# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/glame/glame-1.0.2.ebuild,v 1.3 2004/01/30 06:39:18 drobbins Exp $

DESCRIPTION="an audio file editing utility"
HOMEPAGE="http://glame.sourceforge.net/"
SRC_URI="mirror://sourceforge/glame/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc"
IUSE="nls gnome oggvorbis debug alsa"

DEPEND=">=dev-util/guile-1.4-r3
	>=dev-libs/libxml-1.8.0
	>=dev-libs/libxml2-2.0.0
	>=media-sound/esound-0.2
	>=media-libs/audiofile-0.2.2
	>=sys-devel/autoconf-2.58
	=dev-libs/fftw-2*
	media-sound/mad
	media-libs/ladspa-sdk
	oggvorbis? ( >=media-libs/libvorbis-1.0 )
	gnome? ( <gnome-base/libglade-2 gnome-base/gnome-libs )
	alsa? ( media-libs/alsa-lib )"
RDEPEND="nls? ( >=sys-devel/gettext-0.11.3 )"

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
	export WANT_AUTOCONF=2.5
	cd ${S}/libltdl
	autoconf -f

	cd ${S}
	epatch ${FILESDIR}/gentoo.patch
}

src_compile() {
	local myconf="--enable-ladspa"

	if [ `use gnome` ]
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

	use debug && myconf="${myconf} --enable-swapfiledebug --enable-debug" \
		|| myconf="${myconf} --disable-swapfiledebug --disable-debug"

	use alsa || myconf="${myconf} --disable-alsatest"

	econf ${myconf} || die "Configuration failed"

	emake || die "Compilation failed"
}

src_install () {
	einstall || die "Installation failed"

	if [ `use gnome` ]
	then
		dodir /usr/share/pixmaps
		dosym ../glame/pixmaps/glame-logo.jpg \
		      /usr/share/pixmaps/glame-logo.jpg
	fi

	dodoc ABOUT-NLS AUTHORS BUGS CREDITS ChangeLog MAINTAINERS \
		NEWS README TODO
}
