# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/axiom/axiom-9999.ebuild,v 1.1 2005/01/16 16:39:20 plasmaroo Exp $

ECVS_AUTH='ext'
export CVS_RSH='ssh'
ECVS_SERVER='savannah.gnu.org:/cvsroot/axiom'
ECVS_MODULE='axiom'
ECVS_USER='anoncvs'
ECVS_PASS=''
ECVS_CVS_OPTIONS='-dP'
ECVS_SSH_HOST_KEY='savannah.gnu.org,199.232.41.3 ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAIEAzFQovi+67xa+wymRz9u3plx0ntQnELBoNU4SCl3RkwSFZkrZsRTC0fTpOKatQNs1r/BLFoVt21oVFwIXVevGQwB+Lf0Z+5w9qwVAQNu/YUAFHBPTqBze4wYK/gSWqQOLoj7rOhZk0xtAS6USqcfKdzMdRWgeuZ550P6gSzEHfv0='

inherit cvs eutils

IUSE=''
S=${WORKDIR}/${ECVS_MODULE}
DESCRIPTION='Axiom is a general purpose Computer Algebra system.'
SRC_URI=''
HOMEPAGE='http://axiom.axiom-developer.org/index.html'

DEPEND='virtual/x11
	virtual/tetex'

SLOT='0'
LICENSE='GPL-2'
KEYWORDS='~x86'

pkg_setup() {
	echo
	ewarn 'WARNING: This is a *live* *CVS* ebuild and thus may have'
	ewarn '         serious stability issues and may even not build...'
	echo
	ewarn 'Please make sure you have at least 0.6GB of space for Axiom'
	ewarn 'to build. The compilation will take several *HOURS* so be'
	ewarn 'patient...'
	echo

	epause 5
}

src_setenv() {
	export AXIOM=`pwd`/mnt/linux
	export PATH=${AXIOM}/bin:${PATH}

	# For TeXMF and sandbox happiness
	export VARTEXFONTS=${WORKDIR}/../temp
	export TEXMF="{${VARTEXFONTS},!!/usr/share/texmf}"
}

src_compile() {
	src_setenv

	# Patch the lsp Makefile since GCL goes kaboom with newer BFDs
	# from Portage, so we need to use the BFD distributed with GCL for
	# things to compile and work.
	sed -i -e 's/--enable-statsysbfd/--enable-locbfd --disable-statsysbfd/' Makefile.pamphlet || die 'Failed to patch the lsp Makefile!'

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
	sed -e '1d;2i AXIOM=/opt/axiom' -i ${D}/usr/bin/axiom || die 'Failed to patch axiom runscript!'

	# Get rid of /mnt/linux
	cd ${D}/opt/axiom
	mv mnt/linux/* .
	rm -rf mnt

	sed -e 's/AXIOMsys/sman/g' ${D}/usr/bin/axiom > ${D}/usr/bin/sman
	sed -e 's:$AXIOM/bin/clef -e ::g' ${D}/usr/bin/axiom > ${D}/usr/bin/AXIOMsys
	chmod +x ${D}/usr/bin/sman
	chmod +x ${D}/usr/bin/AXIOMsys
}
