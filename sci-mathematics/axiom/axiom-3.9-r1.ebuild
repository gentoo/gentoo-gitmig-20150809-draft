# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/axiom/axiom-3.9-r1.ebuild,v 1.3 2006/08/25 11:12:08 metalgod Exp $

inherit eutils

DESCRIPTION="Axiom is a general purpose Computer Algebra system"
HOMEPAGE="http://axiom.axiom-developer.org/"
SRC_URI="http://axiom.axiom-developer.org/axiom-website/DOWNLOADS/axiom-Sept2005-src.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/tetex
	|| (
		x11-libs/libXaw
		virtual/x11
	)"

S="${WORKDIR}/axiom"

src_setenv() {
	export AXIOM=`pwd`/mnt/linux
	export PATH=${AXIOM}/bin:${PATH}
}

src_compile() {
	src_setenv

	# Patch the lsp Makefile since GCL goes kaboom with newer BFDs
	# from Portage, so we need to use the BFD distributed with GCL for
	# things to compile and work.
	sed -i -e 's/--enable-statsysbfd/--enable-locbfd --disable-statsysbfd/' Makefile.pamphlet || die 'Failed to patch the lsp Makefile!'

	# Fix gcl so the "real" Axiom can compile code after we're out of the chroot
	cp ${FILESDIR}/gcl-2.6.7.fix-out-of-build-root-compile.patch.input ${S}/zips/gcl-2.6.7.fix-out-of-build-root-compile.patch
	cp ${FILESDIR}/gcl-2.6.7.fix-configure.in-gentoo.patch.input ${S}/zips/gcl-2.6.7.fix-configure.in-gentoo.patch
	cp ${FILESDIR}/noweb-2.9-insecure-tmp-file.patch.input ${S}/zips/noweb-2.9-insecure-tmp-file.patch
	epatch ${FILESDIR}/gcl-2.6.7.fix-out-of-build-root-compile.Makefile.patch || die 'Failed to patch the lsp pamphlet!'
	epatch ${FILESDIR}/gcl-2.6.7.fix-configure.in-gentoo.Makefile.patch || die 'Failed to patch the lsp pamphlet!'
	epatch ${FILESDIR}/noweb-2.9-insecure-tmp-file.Makefile.patch || die 'Failed to patch noweb security issue!'

	# Sandbox happiness, fix noweb
	cd ${WORKDIR}
	mkdir noweb
	cd noweb
	tar zxf ${S}/zips/noweb-2.10a.tgz
	sed -i -e 's/-texhash || echo "Program texhash not found or failed"//' src/Makefile* ${S}/zips/noweb.src.Makefile*
	tar czf ${S}/zips/noweb-2.10a.tgz *
	cd ${S}
	rm ${WORKDIR}/noweb -rf

	# Fix compile bugs (if sed fails, it's fixed; so we don't || die :-])
	#	(plasmaroo; 20050116)
	sed -e 's/struct termio ptermio;/struct termios ptermio;/' -i src/clef/edible.c.pamphlet
	mkdir src/graph/viewports

	# Let the fun begin...
	./configure
	make || die # -jX breaks
}

src_install() {
	src_setenv

	dodir /usr/bin
	einstall INSTALL=${D}/opt/axiom COMMAND=${D}/usr/bin/axiom || die 'Failed to install Axiom!'
	sed -e '2d;3i AXIOM=/opt/axiom' -i ${D}/usr/bin/axiom ${D}/opt/axiom/mnt/linux/bin/axiom || die 'Failed to patch axiom runscript!'
	cat <<- EOF > ${D}/usr/bin/AXIOMsys
		#!/bin/sh -
		AXIOM=/opt/axiom
		export AXIOM
		PATH=\${AXIOM}/bin:\${PATH}
		export PATH
		exec \$AXIOM/bin/AXIOMsys \$*
	EOF

	# Get rid of /mnt/linux
	cd ${D}/opt/axiom
	mv mnt/linux/* .
	rm -rf mnt

	sed -e 's/AXIOMsys/sman/g' ${D}/usr/bin/axiom > ${D}/usr/bin/sman
	chmod +x ${D}/usr/bin/sman
	chmod +x ${D}/usr/bin/AXIOMsys
}
