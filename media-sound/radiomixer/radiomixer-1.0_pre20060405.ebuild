# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/radiomixer/radiomixer-1.0_pre20060405.ebuild,v 1.1 2006/04/05 22:20:32 jokey Exp $

inherit kde-functions eutils

DESCRIPTION="Live Radio production software written by and used for open-radio.org"
HOMEPAGE="http://sourceforge.net/projects/radiomixer"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="alsa debug jack mad vorbis"

DEPEND="media-libs/libsamplerate
	alsa? ( virtual/alsa )
	jack? ( media-sound/jack-audio-connection-kit )
	mad? ( media-libs/libmad )
	vorbis? ( media-libs/libvorbis )"

S=${WORKDIR}/${PN}

need-qt 3.3

pkg_setup() {
	einfo
	einfo "Jack mode is recommended by upstream."
	einfo

	if ! use vorbis ; then
		ewarn
		ewarn "Usage without vorbis support is not recommended."
		ewarn "You would only be able to mix channels but not play any files."
		ewarn
		ewarn "Giving you 5 seconds to think about it"
		ewarn
		epause 5
	fi
}

src_compile() {
	cd ${S}

	local myconf
	if ! use alsa ; then
	    myconf="${myconf} --disable-alsa"
	fi
	if ! use jack ; then
	    myconf="${myconf} --disable-jack"
	fi
	if ! use mad ; then
	    myconf="${myconf} --disable-mad"
	fi
	if ! use vorbis ; then
	    myconf="${myconf} --disable-vorbis"
	fi
	if use debug ; then
		myconf="${myconf} --debug"
	fi

	./configure ${myconf}

	einfo "Using QTDIR: '$QTDIR'."

	# Make sure we use the right qt version
	PATH=${QTDIR}/bin:${PATH}
	LD_LIBRARY_PATH=${QTDIR}/lib:${LD_LIBRARY_PATH}
	DYLD_LIBRARY_PATH=${QTDIR}/lib:${DYLD_LIBRARY_PATH}
	export QTDIR PATH LD_LIBRARY_PATH DYLD_LIBRARY_PATH

	${QTDIR}/bin/qmake -unix radiomixer.pro || die "qmake failed"

	emake || die "emake failed"
}

src_install() {
	dobin bin/radiomixer || die "dobin failed"
}

