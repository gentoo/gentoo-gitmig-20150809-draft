# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/nvrec/nvrec-0.1_pre20030217-r1.ebuild,v 1.3 2003/04/25 15:59:22 vapier Exp $

inherit eutils

MY_VER="20030217"
DESCRIPTION="High quality video capture for Linux"
HOMEPAGE="http://${PN}.sourceforge.net/"
SRC_URI="http://${PN}.sourceforge.net/downloads/${PN}-${MY_VER}.tar.gz
	mirror://sourceforge/ffmpeg/ffmpeg-0.4.6.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="avi quicktime sdl oggvorbis"

DEPEND="dev-lang/perl
	>=sys-devel/automake-1.6.1
	>=sys-devel/autoconf-2.53
	avi? ( media-video/avifile )
	quicktime? ( media-libs/libquicktime )
	sdl? ( media-libs/libsdl )
	sdl? ( media-sound/mad )
	media-libs/divx4linux
	media-sound/lame
	media-video/ffmpeg"
RDEPEND="avi? ( media-video/avifile )
	quicktime? ( media-libs/libquicktime )
	sdl? ( media-libs/libsdl )
	sdl? ( media-sound/mad )
	media-libs/divx4linux
	media-sound/lame"

S=${WORKDIR}/${PN}

src_unpack() {
	local ffversion
	ffversion="ffmpeg-0.4.6-r1"
	ffP="ffmpeg-0.4.6"
	export ffversion
	bash ${FILESDIR}/get_ffmpeg_functions.sh > ${T}/funcs.sh
	source ${T}/funcs.sh
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${MY_VER}.patch
	ffS=${WORKDIR}/${ffP}	
	cd ${ffS}
	epatch ${PORTDIR}/media-video/ffmpeg/files/${ffP}-Makefiles.diff
	cd ${WORKDIR}
	ln -s ${ffP} ffmpeg
}

src_compile() {
	cd ${ffS}
	ffmpeg_src_compile
	cd ${S}	
	./bootstrap
	local myconf
	myconf="$(use_with avi avifile)"
	myconf="${myconf} $(use_with quicktime)"
	myconf="${myconf} $(use_with sdl sdl) $(use_with sdl mad)"
	econf || die "configure failed"
	# ugly ugly ugly... but no configure option there 
	use oggvorbis && ( sed < Makefile > Makefile.new -e \
		's/\(^.*LDADD = .*\)/\1 -lvorbis -lvorbisenc/' && \
		mv Makefile.new Makefile)
	emake || die "make failed"
}

src_install() {
	einstall || die "install failed"
	insinto /etc
	doins etc/nvrec.conf
}
