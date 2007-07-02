# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/glame/glame-1.0.2.ebuild,v 1.18 2007/07/02 15:14:34 peper Exp $

IUSE="nls vorbis debug alsa"

inherit eutils

DESCRIPTION="an audio file editing utility"
HOMEPAGE="http://glame.sourceforge.net/"
SRC_URI="mirror://sourceforge/glame/${P}.tar.gz"
RESTRICT="mirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc amd64 ~ppc"

RDEPEND=">=dev-scheme/guile-1.4-r3
	>=dev-libs/libxml-1.8.0
	>=dev-libs/libxml2-2.0.0
	>=media-sound/esound-0.2
	>=media-libs/audiofile-0.2.2
	=sci-libs/fftw-2*
	media-sound/madplay
	media-libs/ladspa-sdk
	vorbis? ( >=media-libs/libvorbis-1.0 )
	alsa? ( media-libs/alsa-lib )"

DEPEND="${RDEPEND}
	>=sys-devel/autoconf-2.58
	nls? ( >=sys-devel/gettext-0.11.3 )"

src_unpack() {
	unpack ${A}

	# fix NLS problem (bug #7587)
	if ! use nls
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
	epatch ${FILESDIR}/${P}-cflags.patch
}

src_compile() {
	local myconf="--enable-ladspa"

	use nls	&& myconf="--enable-nls" \
		|| myconf="--disable-nls"

	myconf="${myconf} --disable-gui"

	use debug && myconf="${myconf} --enable-swapfiledebug --enable-debug" \
		|| myconf="${myconf} --disable-swapfiledebug --disable-debug"

	use alsa || myconf="${myconf} --disable-alsatest"

	econf ${myconf} || die "Configuration failed"

	emake || die "Compilation failed"
}

src_install () {
	einstall || die "Installation failed"

	dodoc AUTHORS BUGS CREDITS ChangeLog MAINTAINERS \
		NEWS README TODO
}
