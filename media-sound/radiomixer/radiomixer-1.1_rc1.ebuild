# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/radiomixer/radiomixer-1.1_rc1.ebuild,v 1.1 2007/12/13 16:15:40 jokey Exp $

inherit kde-functions eutils

DESCRIPTION="Live Radio production software written by and used for open-radio.org"
HOMEPAGE="http://sourceforge.net/projects/radiomixer"
SRC_URI="mirror://sourceforge/radiomixer/${PN}-1.1RC1.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="alsa debug hwmixer jack mad vorbis"

DEPEND="media-libs/libsamplerate
	alsa? ( media-libs/alsa-lib )
	jack? ( media-sound/jack-audio-connection-kit )
	mad? ( media-libs/libmad )
	vorbis? ( media-libs/libvorbis )"

need-qt 3.3

S=${WORKDIR}/${PN}-1.1RC1

pkg_setup() {
	if ! use alsa && ! use jack ; then
		eerror
		eerror "Neither alsa nor jack USE flag is set, thus no"
		eerror "no sound support would be built."
		eerror
		eerror "Please at least set either alsa or jack USE flag."
		eerror
		die "Adjust your USE flags"
	fi

	if ! use jack && ! use mad && ! use vorbis ; then
		eerror
		eerror "You need to set at least one of the following"
		eerror "USE flags to be able to mix / play some music:"
		eerror
		eerror "jack, mad, vorbis"
		eerror
		die "Adjust your USE flags"
	fi

	if ! use mad && ! use vorbis ; then
		ewarn
		ewarn "As you didn't set vorbis and mad USE flag,"
		ewarn "you would only be able to mix channels but"
		ewarn "cannot play any files."
		ewarn
		ewarn "Giving you 5 seconds to think about it"
		ewarn
		epause 5
		echo
	fi

	elog
	elog "Jack mode is recommended by upstream."
	elog
}

src_compile() {
	local myconf
	# broken without
	myconf="${myconf} --enable-songdb"
	if ! use alsa ; then
		myconf="--disable-alsa"
	fi
	if use hwmixer ; then
		myconf="${myconf} --enable-hwmixer"
	fi
	if ! use jack ; then
		myconf="${myconf} --disable-jackd"
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

	# Ma5ke sure we use the right qt version
	PATH=${QTDIR}/bin:${PATH}
	LD_LIBRARY_PATH=${QTDIR}/lib:${LD_LIBRARY_PATH}
	DYLD_LIBRARY_PATH=${QTDIR}/lib:${DYLD_LIBRARY_PATH}
	export QTDIR PATH LD_LIBRARY_PATH DYLD_LIBRARY_PATH
	einfo "Using QTDIR: '$QTDIR'."

	./configure ${myconf}

	emake || die "emake failed"
}

src_install() {
	dobin bin/radiomixer || die "dobin failed"
}
