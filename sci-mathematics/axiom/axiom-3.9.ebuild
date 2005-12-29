# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/axiom/axiom-3.9.ebuild,v 1.1 2005/12/29 23:32:31 plasmaroo Exp $

inherit eutils

DESCRIPTION="Axiom is a general purpose Computer Algebra system"
HOMEPAGE="http://axiom.axiom-developer.org/index.html"
SRC_URI="http://axiom.axiom-developer.org/axiom-website/DOWNLOADS/axiom-Sept2005-src.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/x11
	virtual/tetex"

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
	epatch ${FILESDIR}/gcl-2.6.7.fix-out-of-build-root-compile.Makefile.patch || die 'Failed to patch the lsp pamphlet!'

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

	# Get rid of /mnt/linux
	cd ${D}/opt/axiom
	mv mnt/linux/* .
	rm -rf mnt

	sed -e 's/AXIOMsys/sman/g' ${D}/usr/bin/axiom > ${D}/usr/bin/sman
	sed -e 's:$AXIOM/bin/clef -e ::g' ${D}/usr/bin/axiom > ${D}/usr/bin/AXIOMsys
	chmod +x ${D}/usr/bin/sman
	chmod +x ${D}/usr/bin/AXIOMsys
}
