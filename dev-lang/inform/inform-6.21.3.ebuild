# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/inform/inform-6.21.3.ebuild,v 1.2 2003/04/23 15:11:46 vapier Exp $

MY_PV=6.21
LIB_V=610
DESCRIPTION="design system for interactive fiction"
HOMEPAGE="http://www.inform-fiction.org/"
SRC_URI="http://mirror.ifarchive.org/if-archive/unprocessed/${P}.tar.gz
	http://mirror.ifarchive.org/if-archive/infocom/compilers/inform6/source/${P}.tar.gz
	http://www.ifarchive.org/if-archive/infocom/compilers/inform6/source/${P}.tar.gz
	http://www.eblong.com/zarf/glulx/libg${LIB_V}.tar.Z"

LICENSE="Inform"
SLOT="0"
KEYWORDS="~x86"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}

	# Canonicalize the library filenames
	mv ${WORKDIR}/libg${LIB_V}/{E,e}nglish.h
	mv ${WORKDIR}/libg${LIB_V}/{G,g}rammar.h
	mv ${WORKDIR}/libg${LIB_V}/{P,p}arser.h
	mv ${WORKDIR}/libg${LIB_V}/{V,v}erbLib.h

	# Replace the original library with Plotkin's
	#	bi-platform version
	mv ${WORKDIR}/libg${LIB_V}/* ${S}/lib/
}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall || die

	dodoc AUTHORS NEWS README* VERSION lib/CHANGES

	docinto tutorial
	dodoc tutor/README tutor/*.txt tutor/*.inf

	# correct the placement of a few things
	mv ${D}/usr/share/${PN}/manual ${D}/usr/share/doc/${PF}/html
	mv ${D}/usr/info ${D}/usr/share/info
	rm -rf ${D}/usr/info

	# fix the symlink foo
	dosym /usr/bin/inform-${MY_PV} /usr/bin/inform

	# symlinks for libraries
	dosym /usr/share/inform/${MY_PV}/module/{e,E}nglish.h
	dosym /usr/share/inform/${MY_PV}/module/{g,G}rammar.h
	dosym /usr/share/inform/${MY_PV}/module/{p,P}arser.h
	dosym /usr/share/inform/${MY_PV}/module/{v,V}erblib.h
	dosym /usr/share/inform/${MY_PV}/module/{v,V}erblib.h
}
