# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/emboss/emboss-2.9.0.ebuild,v 1.2 2004/07/20 20:36:30 ribosome Exp $

DESCRIPTION="The European Molecular Biology Open Software Suite: a sequence analysis package."
HOMEPAGE="http://emboss.sourceforge.net/"
SRC_URI="ftp://ftp.uk.embnet.org/pub/EMBOSS/EMBOSS-${PV}.tar.gz"
LICENSE="GPL-2 LGPL-2"

SLOT="0"
KEYWORDS="~x86"
IUSE="X png no-biodata"

DEPEND="X? ( virtual/x11 )
	png? (
		sys-libs/zlib
		media-libs/libpng
		>=media-libs/gd-1.8
	)
	app-sci/primer3
	app-sci/clustalw"

PDEPEND="!no-biodata? (
		app-sci/aaindex
		app-sci/cutg
		app-sci/prints
		app-sci/prosite
		app-sci/rebase
		app-sci/transfac
	)"

S=${WORKDIR}/EMBOSS-${PV}

src_compile() {
	EXTRA_CONF="--includedir=${D}/usr/include/emboss"
	! use X && EXTRA_CONF="${EXTRA_CONF} --without-x"
	! use png && EXTRA_CONF="${EXTRA_CONF} --without-pngdriver"

	econf ${EXTRA_CONF} || die
	# Do not install the JEMBOSS component (the --without-java configure option
	# does not work). JEMBOSS will be available as a separate package.
	sed -i -e 's/SUBDIRS = plplot ajax nucleus emboss test doc jemboss/SUBDIRS = plplot ajax nucleus emboss test doc/' Makefile
	emake || die
}

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog FAQ NEWS README THANKS

	# Install env file for setting libplplot and acd files path.
	insinto /etc/env.d
	newins ${FILESDIR}/22emboss-r1 22emboss

	# Symlink preinstalled docs to /usr/share/doc.
	dosym /usr/share/EMBOSS/doc/manuals /usr/share/doc/${PF}/manuals
	dosym /usr/share/EMBOSS/doc/programs /usr/share/doc/${PF}/programs
	dosym /usr/share/EMBOSS/doc/tutorials /usr/share/doc/${PF}/tutorials
}
