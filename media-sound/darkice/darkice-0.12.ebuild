# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/darkice/darkice-0.12.ebuild,v 1.4 2003/09/07 00:06:04 msterret Exp $

DESCRIPTION="IceCast live streamer delivering Ogg and mp3 streams simulatenously to multiple hosts."
HOMEPAGE="http://darkice.sourceforge.net/"
KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"
IUSE="encode oggvorbis"

SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

DEPEND="encode?	( >=media-sound/lame-1.89 )
	oggvorbis? ( >=media-libs/libvorbis-1.0 )"

S=${WORKDIR}/${P}

src_unpack() {
	unpack ${A}

	patch -p0 < ${FILESDIR}/${P}-gentoo.diff
}

src_compile() {
	local myconf=""

	if [ ! "`use encode`" ] && [ ! "`use oggvorbis`" ]
	then

		eerror "You need support for mp3 or Ogg Vorbis enconding for this"
		eerror "package. Please merge again with at least one of the "
		eerror "\`encode' and \`oggvorbis' USE flags enabled:"
		eerror
		eerror "  # USE=\"encode\" emerge darkice"
		eerror "  # USE=\"oggvorbis\" emerge darkice"
		die "Won't build without support for lame nor vorbis"
	fi

	use encode    || myconf="--without-lame"
	use oggvorbis || myconf="--without-vorbis"

	econf ${myconf}

	emake || die "Compilation failed"
}

src_install() {
	einstall darkicedocdir=${D}/usr/share/doc/${PF} || die

	dodoc AUTHORS ChangeLog COPYING NEWS README TODO
}
