# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-sound/darkice/darkice-0.10.1.ebuild,v 1.1 2002/08/13 18:34:47 agenkin Exp $

DESCRIPTION="IceCast live streamer delivering Ogg and mp3 streams simulatenously to multiple hosts."
HOMEPAGE="http://darkice.sourceforge.net/"
LICENSE="GPL-2"

DEPEND="encode?	( >=media-sound/lame-1.89 )
	oggvorbis? ( >=media-libs/libvorbis-1.0 )"

SLOT="0"
KEYWORDS="x86"
SRC_URI="http://unc.dl.sourceforge.net/sourceforge/darkice/darkice-${PV}.tar.gz"
S=${WORKDIR}/${P}

src_compile() {
	local myconf
	use encode && myconf="--with-lame"
	use oggvorbis && myconf="${myconf} --with-vorbis"
	
	./configure ${myconf} \
                    --prefix=/usr \
                    --sysconfdir=/etc \
                    --mandir=/usr/share/man \
                    --infodir=/usr/share/info || die
	emake || die
}

src_install() {
	einstall darkicedocdir=${D}/usr/share/doc/${PF} || die
	
	dodoc README TODO NEWS AUTHORS ChangeLog NEWS
}
