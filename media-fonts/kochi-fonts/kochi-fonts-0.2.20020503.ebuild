# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/kochi-fonts/kochi-fonts-0.2.20020503.ebuild,v 1.1 2003/06/02 13:47:09 seemant Exp $

DESCRIPTION="Kochi Gothic and Mincho Japanese TrueType fonts"

HOMEPAGE="http://www.on.cs.keio.ac.jp/~yasu/jp_fonts.html"

LICENSE="free-noncomm"
SLOT="0"
KEYWORDS="x86 sparc  ppc"

DEPEND=">=x11-base/xfree-4.2.0-r9
	>=x11-misc/ttmkfdir-0.0-r1"

SRC_PATH="http://www.on.cs.keio.ac.jp/~yasu/linux/fonts"

SRC_URI="${SRC_PATH}/kochi-gothic-${PV}.tar.bz2
	 ${SRC_PATH}/kochi-mincho-${PV}.tar.bz2"

src_unpack () {

	unpack kochi-{gothic,mincho}-${PV}.tar.bz2
}

src_install () {

	# install fonts
	insinto /usr/X11R6/lib/X11/fonts/truetype
	doins ${WORKDIR}/kochi-gothic/fonts/kochi-gothic.ttf
	doins ${WORKDIR}/kochi-mincho/fonts/kochi-mincho.ttf

	# install READMEs, licenses, etc. as required
	dodir /usr/share/doc/${PF}
	cp -a ${WORKDIR}/kochi-gothic/docs/* ${D}usr/share/doc/${PF}
	cp -a ${WORKDIR}/kochi-mincho/docs/* ${D}usr/share/doc/${PF}
}

rebuild_fontfiles() {

	einfo "Refreshing fonts.scale and fonts.dir..."

	cd /usr/X11R6/lib/X11/fonts/truetype

	# recreate fonts.scale
	ttmkfdir > fonts.scale \
		|| die "Unable to create fonts.scale! Please emerge ttmkfdir and try again."

	# recreate fonts.dir
	mkfontdir -e /usr/X11R6/lib/X11/fonts/encodings
}

pkg_postinst() {
	   
	rebuild_fontfiles
}

pkg_postrm() {

	rebuild_fontfiles
}
