# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-qtlibs/emul-linux-x86-qtlibs-10.0.ebuild,v 1.4 2007/02/13 21:13:22 blubb Exp $

DESCRIPTION="Provides precompiled 32bit libraries"
HOMEPAGE="http://amd64.gentoo.org/emul/content.xml"
SRC_URI="mirror://gentoo/qt-3.3.6-r4.tbz2
		mirror://gentoo/kdelibs-3.5.5-r8.tbz2"

LICENSE="|| ( QPL-1.0 GPL-2 ) GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE=""

RESTRICT="nostrip"
S=${WORKDIR}

DEPEND=""
RDEPEND=">=app-emulation/emul-linux-x86-baselibs-10.0
		>=app-emulation/emul-linux-x86-xlibs-7.0-r7"

pkg_setup() {
	einfo "Note: You can safely ignore the 'trailing garbage after EOF'"
	einfo "      warnings below"
}

src_unpack() {
	unpack ${A}

	# we only want the libs
	find ${S}/usr ! -type d ! -name '*.so*' | xargs rm -f
	NEEDED="(libDCOP.so|libkdecore.so|libkdefx.so|libqt-mt.so|libqt.so|libqui.so)"
	find ${S} -name '*.so*' | egrep -v "${NEEDED}" | xargs rm -f
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
