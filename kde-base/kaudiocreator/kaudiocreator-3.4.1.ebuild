# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kaudiocreator/kaudiocreator-3.4.1.ebuild,v 1.3 2005/05/26 17:14:24 danarmak Exp $

KMNAME=kdemultimedia
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE CD ripper and audio encoder frontend"
KEYWORDS="~x86 ~amd64 ~ppc64 ~ppc ~sparc"
IUSE="encode flac vorbis"
DEPEND="$(deprange $PV $MAXKDEVER kde-base/libkcddb)
	media-sound/cdparanoia"

# External encoders used - no optional compile-time support
RDEPEND="$DEPEND
vorbis? ( media-sound/vorbis-tools )
flac? ( media-libs/flac )
encode? ( media-sound/lame )"

KMCOPYLIB="libkcddb libkcddb"
KMEXTRACTONLY="libkcddb"
KMCOMPILEONLY="kscd/libwm
	libkcddb/"

src_compile () {
	DO_NOT_COMPILE=libkcddb kde-meta_src_compile myconf configure
	cd $S/libkcddb && make configbase.h
	cd $S/libkcddb && make cdinfodialogbase.h
	DO_NOT_COMPILE=libkcddb kde-meta_src_compile make
}
