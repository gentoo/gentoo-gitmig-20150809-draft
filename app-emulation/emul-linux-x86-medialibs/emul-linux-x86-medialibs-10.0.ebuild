# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-medialibs/emul-linux-x86-medialibs-10.0.ebuild,v 1.3 2007/02/19 21:57:36 blubb Exp $

DESCRIPTION="Provides precompiled 32bit libraries"
HOMEPAGE="http://amd64.gentoo.org/emul/content.xml"
SRC_URI="mirror://gentoo/fribidi-0.10.7.tbz2
		mirror://gentoo/giflib-4.1.4.tbz2
		mirror://gentoo/lame-3.96.1.tbz2
		mirror://gentoo/libdv-1.0.0-r1.tbz2
		mirror://gentoo/libmad-0.15.1b-r2.tbz2
		mirror://gentoo/libtheora-1.0_alpha6-r1.tbz2
		mirror://gentoo/lzo-2.02-r1.tbz2
		mirror://gentoo/xvid-1.1.0-r3.tbz2"

LICENSE="GPL-2 LGPL-2.1 MIT as-is xiph"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE=""

RESTRICT="strip"
S=${WORKDIR}

DEPEND=""
RDEPEND=">=app-emulation/emul-linux-x86-baselibs-10.0
		>=app-emulation/emul-linux-x86-soundlibs-2.5-r2
		>=app-emulation/emul-linux-x86-xlibs-10.0"

pkg_setup() {
	einfo "Note: You can safely ignore the 'trailing garbage after EOF'"
	einfo "	  warnings below"
}

src_unpack() {
	unpack ${A}

	find ${S}/usr ! -type d ! -name '*.so*' | xargs rm -f
}

src_install() {
	for dir in etc/env.d etc/revdep-rebuild ; do
		if [[ -d ${S}/${dir} ]] ; then
			for f in ${S}/${dir}/* ; do
				mv -f $f{,-emul}
			done
		fi
	done

	# remove void directories or portage will show wierd output
	find ${S} -type d -depth | xargs rmdir 2&>/dev/null

	cp -a "${WORKDIR}"/* "${D}"/ || die "copying files failed!"
}
