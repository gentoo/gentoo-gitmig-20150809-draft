# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Dan Armak <danarmak@gentoo.org>
# /space/gentoo/cvsroot/gentoo-x86/media-video/transcode/transcode-0.5.3.ebuild,v 1.2 2002/04/05 08:44:03 verwilst Exp

P=transcode-0.6.0pre4
S=${WORKDIR}/${P}
DESCRIPTION="video stream processing tool"
SRC_URI="http://www.theorie.physik.uni-goettingen.de/~ostreich/transcode/pre/${P}.tgz"
HOMEPAGE="http://www.theorie.physik.uni-goettingen.de/~ostreich/transcode"

# Note: transcode can use pretty much any media-related package ever written as
# a plugin. An exhaustive dep list would make me add about 20-30 packages to 
# portage. perhaps another time :-)

DEPEND="media-libs/libdv
	media-libs/libsdl
	=x11-libs/gtk+-1.2*
	>=media-video/avifile-0.6
	dvd? ( media-libs/libdvdread )
	encode? ( >=media-sound/lame-3.89 )
	libmpeg3?( media-libs/libmpeg3 )
	quicktime? ( media-libs/quicktime4linux )"

src_compile() {

	local myconf
	
	use encode \
		&& myconf="${myconf} --with-lame" \
		|| myconf="${myconf} --without-lame"
	
	use libmpeg3 \
		&& myconf="${myconf} --with-libmpeg3" \
		|| myconf="${myconf} --without-libmpeg3"
	
    ./configure \
		--prefix=/usr \
		${myconf} || die

    emake all || die

}

src_install () {

    make \
		DESTDIR=${D} \
		install || die
}
