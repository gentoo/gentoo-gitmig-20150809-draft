# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-qtlibs/emul-linux-x86-qtlibs-10.0.ebuild,v 1.2 2007/02/13 14:04:00 blubb Exp $

DESCRIPTION="Provides precompiled 32bit libraries"
HOMEPAGE="http://amd64.gentoo.org/emul/content.xml"
SRC_URI="mirror://gentoo/qt-3.3.6-r4.tbz2
		mirror://gentoo/kdelibs-3.5.5-r8.tbz2
		mirror://gentoo/kdeartwork-styles-3.5.5.tbz2"

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
	einfo
	elog "This package contains prebuilt versions of the following packages:"
	for a in ${A} ; do 
		elog "	${a//.tbz2}"
	done
	einfo
	echo
	einfo "Note: You can safely ignore the 'trailing garbage after EOF'"
	einfo "      warnings below"
}

src_unpack() {
	unpack ${A}

	# we only want the libs
	cd ${S}/usr && rm -rf share/
	for dir in ${S}/usr/{qt/3,kde/3.5} ; do
		find ${dir} -depth | egrep -v "(^${dir}/lib32|^${dir}$)" | xargs rm -rf
	done
}

src_install() {
	 # nobody needs *.la, *.h *.a
	 find ${S} -type f -name '*.a' -or -name '*.la' -or -name '*.h' \
		| xargs rm -f

	for dir in etc/env.d etc/revdep-rebuild ; do
		if [[ -d ${S}/${dir} ]] ; then
			for f in ${S}/${dir}/* ; do
				mv -f $f{,-emul}
			done
		fi
	done

	cp -a "${WORKDIR}"/* "${D}"/ || die "copying files failed!"
}
