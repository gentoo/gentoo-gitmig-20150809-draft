# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/pvm-povray/pvm-povray-3.1g-r1.ebuild,v 1.2 2006/01/18 07:28:55 spyderous Exp $

inherit eutils

S=${WORKDIR}/povray31
DESCRIPTION="The Persistence Of Vision Ray Tracer - PVM version"
SRC_URI="http://www.ibiblio.org/gentoo/distfiles/povuni_s_3.1.tgz
	http://www.ibiblio.org/gentoo/distfiles/povuni_d_3.1.tgz
	mirror://sourceforge/pvmpov/pvmpov-3.1g2.tgz"
HOMEPAGE="http://pvmpov.sourceforge.net/"

SLOT="0"
LICENSE="povlegal-3.1g"
KEYWORDS="~x86 sparc"
IUSE="X svga"

RDEPEND="sys-cluster/pvm"

DEPEND="media-libs/libpng
	sys-libs/zlib
	svga? ( media-libs/svgalib )
	X? ( || ( x11-libs/libX11 virtual/x11 ) )"

src_unpack() {
	unpack pvmpov-3.1g2.tgz
	unpack povuni_s_3.1.tgz
	unpack povuni_d_3.1.tgz

	# Copy pvm-pov sources from the pvm-pov tarball
	cp -R ${WORKDIR}/pvmpov3_1g_2/povray31/source ${S}

	# The PVM Patch
	epatch ${WORKDIR}/pvmpov3_1g_2/pvmpov.patch || die "epatch failed."

	cd ${S}/source/pvm

	cp Makefile.aimk Makefile.aimk.orig
	sed -e 's/\/local//g' Makefile.aimk.orig > Makefile.aimk

	# Use system libpng
	echo "s:^PNGDIR.*:#PNGDIR = /usr/include:" >> Makefile.aimk.sed
	echo "s:^LIBPNGINC.*:#LIBPNGINC =:" >> Makefile.aimk.sed
	echo "s:^LIBPNGLIB.*:LIBPNGLIB = -lpng:" >> Makefile.aimk.sed

	# Use system zlib
	echo "s:^ZLIBDIR.*:#ZLIBDIR =:" >> Makefile.aimk.sed
	echo "s:^ZLIBINC.*:#ZLIBINC =:" >> Makefile.aimk.sed
	echo "s:^ZLIBLIB.*:ZLIBLIB = -lz:" >> Makefile.aimk.sed

	# POVPATH (install path)
	echo 's:^POVPATH.*:POVPATH = $(DESTDIR)/usr:' >> Makefile.aimk.sed

	# Symlinks during install need to get into destdir
	echo 's:$(PVM_ROOT)/bin/$(PVM_ARCH):$(DESTDIR)$(PVM_ROOT)/bin/$(PVM_ARCH):g' >> Makefile.aimk.sed
	echo 's:ln -s $(POVPATH)/bin/$(UTARGET):ln -s /usr/bin/$(UTARGET):g' >> Makefile.aimk.sed
	echo 's:ln -s $(POVPATH)/bin/$(XTARGET):ln -s /usr/bin/$(XTARGET):g' >> Makefile.aimk.sed
	echo 's:ln -s $(POVPATH)/bin/$(STARGET):ln -s /usr/bin/$(STARGET):g' >> Makefile.aimk.sed

	cp Makefile.aimk Makefile.aimk.orig
	sed -f Makefile.aimk.sed Makefile.aimk.orig > Makefile.aimk
}

src_compile() {
	einfo 'Checking for $PVM_ROOT...'

	if [ -z "${PVM_ROOT}" ]
	then
		eerror 'Please set your $PVM_ROOT correctly, it is now empty.'
		eerror 'The $PVM_ROOT variable should point to your PVM '
		eerror "installation's root"
		eerror 'Example $PVM_ROOT : /usr/pvm3/ or /opt/pvm3/'
		die
	fi

	if [ ! -x ${PVM_ROOT}/lib/aimk ]
	then
		eerror "Can not execute ${PVM_ROOT}/lib/aimk."
		eerror 'Make sure your $PVM_ROOT is set correctly'
		eerror 'Example $PVM_ROOT : /usr/pvm3/ or /opt/pvm3/'
		die
	fi

	export PATH="${PATH}:${PVM_ROOT}/lib/"
	einfo '$PVM_ROOT is OK.'

	einfo 'Building pvmpov'

	cd source/pvm
	aimk ${MAKEOPTS} newunix || die

	if use X ; then
		einfo 'Building x-pvmpov'
		aimk ${MAKEOPTS} newxwin || die
	fi

	if use svga ; then
		einfo 'Building s-pvmpov'
		aimk ${MAKEOPTS} newsvga || die
	fi
}

src_install() {

	cd source/pvm
	dodir usr/bin
	dodir usr/lib
	doman ${S}/source/unix/povray.1
	if [ ! -x ${PVM_ROOT}/lib/pvmgetarch ]
	then
		eerror "Can not execute ${PVM_ROOT}/lib/pvmgetarch."
		eerror 'Make sure your $PVM_ROOT is set correctly'
		eerror 'Example $PVM_ROOT : /usr/pvm3/ or /opt/pvm3/'
		die
	fi

	PVMARCH=`${PVM_ROOT}/lib/pvmgetarch`
	export PATH="${PATH}:${PVM_ROOT}/lib/"

	dodir ${PVM_ROOT}/bin/${PVMARCH}
	dodir usr/share/man/man1
	aimk DESTDIR=${D} install || die
}
