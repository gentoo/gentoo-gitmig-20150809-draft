# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/pvm-povray/pvm-povray-3.1g.ebuild,v 1.8 2006/08/24 01:49:59 mr_bones_ Exp $

inherit eutils

S=${WORKDIR}/povray31
DESCRIPTION="The Persistence Of Vision Ray Tracer - PVM version"
SRC_URI="http://www.ibiblio.org/gentoo/distfiles/povuni_s_3.1.tgz
	http://www.ibiblio.org/gentoo/distfiles/povuni_d_3.1.tgz
	mirror://sourceforge/pvmpov/pvmpov-3.1g2.tgz"
HOMEPAGE="http://pvmpov.sourceforge.net/"

SLOT="0"
LICENSE="povlegal-3.1g"
KEYWORDS="x86"
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
	einfo 'Checking for $PVMROOT...'

	if [ -z "${PVMROOT}" ]
	then
		eerror 'Please set your $PVMROOT correctly, it is now empty.'
		eerror 'The $PVMROOT variable should point to your PVM '
		eerror "installation's root"
		eerror 'Example $PVMROOT : /usr/pvm3/ or /opt/pvm3/'
		die
	fi

	if [ ! -x ${PVMROOT}/lib/aimk ]
	then
		eerror "Can not execute ${PVMROOT}/lib/aimk."
		eerror 'Make sure your $PVMROOT is set correctly'
		eerror 'Example $PVMROOT : /usr/pvm3/ or /opt/pvm3/'
		die
	fi

	export PATH="${PATH}:${PVMROOT}/lib/"
	einfo '$PVMROOT is OK.'

	einfo 'Building pvmpov'

	cd source/pvm
	aimk newunix || die

	if use X ; then
		einfo 'Building x-pvmpov'
		aimk newxwin || die
	fi

	if use svga ; then
		einfo 'Building s-pvmpov'
		aimk newsvga || die
	fi
}

src_install() {
	cd source/pvm
	dodir usr/bin
	dodir usr/lib
	doman ${S}/source/unix/povray.1
	if [ ! -x ${PVMROOT}/lib/pvmgetarch ]
	then
		eerror "Can not execute ${PVMROOT}/lib/pvmgetarch."
		eerror 'Make sure your $PVMROOT is set correctly'
		eerror 'Example $PVMROOT : /usr/pvm3/ or /opt/pvm3/'
		die
	fi

	PVMARCH=`${PVMROOT}/lib/pvmgetarch`

	dodir ${PVMROOT}/bin/${PVMARCH}
	dodir usr/share/man/man1
	export PATH="$PATH:/usr/local/pvm3/lib/"
	aimk DESTDIR=${D} install || die
}
