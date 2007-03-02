# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-soundlibs/emul-linux-x86-soundlibs-10.0-r1.ebuild,v 1.3 2007/03/02 15:04:01 blubb Exp $

inherit emul-libs

SRC_URI="mirror://gentoo/alsa-lib-1.0.14_rc1.tbz2
	mirror://gentoo/alsa-oss-1.0.12.tbz2
	arts? ( mirror://gentoo/arts-3.5.5.tbz2 )
	mirror://gentoo/audiofile-0.2.6-r2.tbz2
	mirror://gentoo/esound-0.2.36-r2.tbz2
	mirror://gentoo/jack-audio-connection-kit-0.101.1-r1.tbz2
	mirror://gentoo/libmikmod-3.1.11-r2.tbz2
	mirror://gentoo/libogg-1.1.2.tbz2
	mirror://gentoo/libsndfile-1.0.17.tbz2
	mirror://gentoo/libvorbis-1.1.2.tbz2"

LICENSE="as-is BSD GPL-2 LGPL-2 LGPL-2.1"
KEYWORDS="-* amd64"

IUSE="arts"

RDEPEND=">=app-emulation/emul-linux-x86-baselibs-10.0
		arts? ( >=app-emulation/emul-linux-x86-qtlibs-10.0 )
		!<app-emulation/media-libs-1.1"

src_unpack() {
	ALLOWED="(${S}/etc/env.d|${S}/usr/bin/esddsp|${S}/usr/kde/.*/bin/artsdsp|${S}/usr/bin/aoss)"
	emul-libs_src_unpack

	for f in ${S}/usr/bin/esddsp ${S}/usr/bin/aoss ${S}/usr/kde/*/bin/artsdsp ; do
		mv -f "$f"{,32}
	done
}
