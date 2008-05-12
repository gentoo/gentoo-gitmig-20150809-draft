# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kaudiocreator/kaudiocreator-3.5.9.ebuild,v 1.4 2008/05/12 20:01:55 ranger Exp $

KMNAME=kdemultimedia
EAPI="1"
inherit kde-meta eutils

DESCRIPTION="KDE CD ripper and audio encoder frontend"
KEYWORDS="alpha ~amd64 ~hppa ia64 ppc ~ppc64 sparc ~x86 ~x86-fbsd"
IUSE="encode flac mp3 vorbis"
DEPEND=">=kde-base/libkcddb-${PV}:${SLOT}
	media-sound/cdparanoia"

# External encoders used - no optional compile-time support
RDEPEND="${RDEPEND}
	>=kde-base/kdemultimedia-kioslaves-${PV}:${SLOT}
	encode? ( vorbis? ( media-sound/vorbis-tools )
			flac? ( media-libs/flac )
			mp3? ( media-sound/lame ) )"

KMCOPYLIB="libkcddb libkcddb"
KMEXTRACTONLY="libkcddb"
KMCOMPILEONLY="kscd
	libkcddb/"

PATCHES="${FILESDIR}/kaudiocreator-3.5.6-arts.patch"

src_compile () {
	DO_NOT_COMPILE=libkcddb kde-meta_src_compile myconf configure
	cd "$S"/libkcddb && emake configbase.h cdinfodialogbase.h

	# Library deps seems not to be built as they should :/
	cd "$S"/kscd/libwm/audio && emake libworkmanaudio.la && \
	cd "$S"/kscd/libwm && emake libworkman.la && \
	cd "$S"/kscd && emake libkcompactdisc.la || \
		die "failed to make prerequisite libraries."

	DO_NOT_COMPILE=libkcddb kde-meta_src_compile make
}
