# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-video/transcode/transcode-0.6.0_pre4-r2.ebuild,v 1.2 2002/07/11 06:30:42 drobbins Exp $

MY_P=${P/_/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="video stream processing tool"
SRC_URI="http://www.theorie.physik.uni-goettingen.de/~ostreich/transcode/pre/${MY_P}.tgz"
HOMEPAGE="http://www.theorie.physik.uni-goettingen.de/~ostreich/transcode"

# Note: transcode can use pretty much any media-related package ever written as
# a plugin. An exhaustive dep list would make me add about 20-30 packages to 
# portage. perhaps another time :-)

DEPEND=">=media-libs/a52dec-0.7.3
	media-libs/libdv
	media-libs/libsdl
	=x11-libs/gtk+-1.2*
	>=media-video/avifile-0.6
	dvd? ( media-libs/libdvdread )
	mpeg? ( media-libs/libmpeg3 )
	encode? ( >=media-sound/lame-3.89 )
	quicktime? ( media-libs/quicktime4linux )"

src_unpack() {
	unpack ${A}

	if [ "`gcc --version | cut -f1 -d.`" = "3" ];
	then
		patch -p0 < ${FILESDIR}/transcode-0.6.0_pre4.diff
	fi
}

src_compile() {

	local myconf
	
	use encode \
		&& myconf="${myconf} --with-lame" \
		|| myconf="${myconf} --without-lame"
	
	use mpeg \
		&& myconf="${myconf} --with-libmpeg3" \
		|| myconf="${myconf} --without-libmpeg3"
	
	econf ${myconf} || die

	emake all || die

}

src_install () {

	make \
		DESTDIR=${D} \
		install || die
}
