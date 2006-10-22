# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mpg123/mpg123-0.61.ebuild,v 1.1 2006/10/22 19:04:52 genstef Exp $

DESCRIPTION="Real Time mp3 player"
HOMEPAGE="http://www.mpg123.de/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc-macos ~ppc64 ~sparc ~x86"
IUSE="mmx 3dnow esd nas oss alsa sdl"

RDEPEND="esd? ( media-sound/esound )
	nas? ( media-libs/nas )
	alsa? ( media-libs/alsa-lib )
	sdl? ( media-libs/libsdl )"

DEPEND="${RDEPEND}"

PROVIDE="virtual/mpg123"

src_compile() {
	if use alsa; then
	  audiodev="alsa"
	 elif use oss; then
	  audiodev="oss"
	 elif use sdl; then
	  audiodev="sdl"
	 elif use esd; then
	  audiodev="esd"
	 elif use nas; then
	  audiodev="nas"
	 else die "no audio device selected"
	fi

	if use 3dnow; then
	 myconf="--with-cpu=3dnow"
	elif use mmx; then
	 myconf="--with-cpu=mmx"
	fi

	econf \
	      --with-optimization=0 \
	      --with-audio=$audiodev \
	      ${myconf} || die "econf failed"

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
