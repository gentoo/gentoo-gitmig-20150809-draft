# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/audacity/audacity-1.2.0.ebuild,v 1.2 2004/03/03 23:07:41 dholm Exp $

inherit eutils

MY_PV="${PV/_/-}"
MY_P="${PN}-src-${MY_PV}"

DESCRIPTION="A free, crossplatform audio editor."
HOMEPAGE="http://audacity.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
RESTRICT="nomirror"

LICENSE="GPL-2"
IUSE="encode flac mad oggvorbis"
SLOT="0"
KEYWORDS="~x86 ~ppc"

DEPEND=">=x11-libs/wxGTK-2.2.9
	>=app-arch/zip-2.3
	>=media-libs/id3lib-3.8.0
	media-libs/libid3tag
	>=media-libs/libsndfile-1.0.0
	>=media-libs/libsamplerate-0.0.14
	>=media-libs/ladspa-sdk-1.12
	flac? ( media-libs/flac )
	oggvorbis? ( >=media-libs/libvorbis-1.0 )
	mad? ( >=media-sound/mad-0.14 )
	encode? ( >=media-sound/lame-3.92 )"

S="${WORKDIR}/${MY_P}"

DOC="LICENSE.txt README.txt audacity-1.2-help.htb"

src_compile() {
	local myconf;

	myconf="--with-libsndfile=system --with-id3tag=system"

	# MAD support
	if use mad; then
		myconf="${myconf} --with-libmad=system"
	else
		myconf="${myconf} --with-libmad=none"
	fi

	# FLAC support
	if use flac; then
		myconf="${myconf} --with-libflac=system"
	else
		myconf="${myconf} --with-libflac=none"
	fi

	# Ogg Vorbis support
	if use oggvorbis; then
		myconf="${myconf} --with-vorbis=system"
	else
		myconf="${myconf} --with-vorbis=none"
	fi

	econf ${myconf} || die

	# parallel borks 
	emake -j1 || die
}

src_install() {
	make DESTDIR=${D} install || die

	# Install our docs
	dodoc ${DOC}

	# Remove bad doc install
	rm -rf ${D}/share/doc
}
