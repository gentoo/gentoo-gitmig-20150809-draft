# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Authors: Preston A. Elder <prez@goth.net>, Martin Schlemmer <azarah@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-office/openoffice/openoffice-641d.ebuild,v 1.2 2002/04/17 23:46:32 azarah Exp $

# IMPORTANT:  This is extremely alpha!!!

# notes:
# This will take a HELL of a long time to compile, be warned.
# According to openoffice.org, it takes approximately 12 hours on a
# P3/600 with 256mb ram.  And thats where building is its only task.
#
# You will also need a bucketload of diskspace ... in the order of
# 4-5 gb free to store all the compiled files and installation
# directories.
#
# The information on how to build and what is required comes from:
# http://www.openoffice.org/dev_docs/source/build_linux.html
# http://tools.openoffice.org/ext_comp.html
#
# todo:
# Some kind of install process.

LOC="/opt"
MAIN_VER="`echo ${PV} |sed -e "s:[a-z]::g"`"
S="${WORKDIR}/oo_${PV}_src"
DESCRIPTION="OpenOffice productivity suite"
SRC_URI="http://ny1.mirror.openoffice.org/${PV}/oo_${PV}_src.tar.bz2
	http://sf1.mirror.openoffice.org/${PV}/oo_${PV}_src.tar.bz2
	ftp://ftp.cs.man.ac.uk/pub/toby/gpc/gpc231.tar.Z"
HOMEPAGE="http://www.openoffice.org"

COMMONDEPEND=">=sys-libs/glibc-2.1
	>=sys-devel/perl-5.0
	virtual/x11
	app-arch/zip
	app-arch/unzip
	>=virtual/jdk-1.3.1"

# All these are included with the source archive ...
#       >=media-libs/nas-1.4.1
#       >=media-libs/jpeg-6b
#       >=media-gfx/sane-frontends-1.0.0
#       >=dev-libs/expat-1.95.1
#       >=sys-libs/zlib-1.1.3
#       >=net-misc/neon-0.3.1

# We need gcc-3.0 or greater, as the Mozilla runtime libs is compiled with
# gcc3, and the build segfault with gcc-2.95.3 if we recompile mozilla
# with gcc-2.95.3.
#
# Azarah -- 14 April 2002
RDEPEND="${COMMONDEPEND}
	>=sys-devel/gcc-3.0.4-r3"
DEPEND="${COMMONDEPEND}
	>=sys-devel/gcc-3.0.4-r3
	app-shells/tcsh"

# All these are included with the source archive ...
#       >=dev-util/dmake-3.2.1

SLOT="0"

GCC_VER="`gcc --version`"

# fix a bug with tcsh and dircolors
#
# Azarah -- 10 April 2002
export LS_COLORS=""

src_unpack() {
	cd ${WORKDIR}
	unpack ${A}
	cd ${WORKDIR}/gpc231
	cp gpc.* ${S}/external/gpc
	cd ${S}

	# This allows JDK 1.4.0 to be used
	patch -p1 <${FILESDIR}/${PV}/${P}-configure.patch || die

	# Fixes code errors that stop compile
	patch -p1 <${FILESDIR}/${PV}/${P}-code_err.patch || die

	# This forces exceptions to always be enabled for gcc 3.0.x
	patch -p1 <${FILESDIR}/${PV}/${P}-gcc3.patch || die

	# Debian patch to enable build of zipdep
	#
	# Azarah -- 14 April 2002
	patch -p1 <${FILESDIR}/${PV}/${P}-zipdep-not-found.patch || die

	# Some Debian patches to get the build to use $CC and $CXX,
	# thanks to nidd from #openoffice.org
	#
	# Azarah -- 14 April 2002
	patch -p1 <${FILESDIR}/${PV}/${P}-gcc-version-check.patch || die
	patch -p1 <${FILESDIR}/${PV}/${P}-set-compiler-vars.patch || die
	patch -p1 <${FILESDIR}/${PV}/${P}-use-compiler-vars.patch || die
	patch -p1 <${FILESDIR}/${PV}/${P}-ran-autoconf.patch || die

	# Fix STLport to use gcc-3.x/g++-3.x as compilter when we have
	# gcc-2.95.3 as base compiler.
	#
	# Azarah -- 15 April 2002
	if [ 0`echo ${GCC_VER} | cut -f1 -d.` -eq 2 ]
	then
		patch -p1 <${FILESDIR}/${PV}/${P}-STLport-gcc2-gcc3.patch || die
	fi

	# Now for our optimization flags ...
	cd ${S}/solenv/inc
	cp unxlngi3.mk unxlngi3.mk.orig
	cp unxlngi4.mk unxlngi4.mk.orig
	sed -e "s:^CFLAGSOPT=.*:CFLAGSOPT=${CFLAGS}:g" \
		unxlngi3.mk.orig >unxlngi3.mk
	sed -e "s:^CFLAGSOPT=.*:CFLAGSOPT=${CFLAGS}:g" \
		unxlngi4.mk.orig >unxlngi4.mk
}

src_compile() {

	local myargs=""
	if [ 0`echo ${GCC_VER} | cut -f1 -d.` -eq 3 ]
	then
		myargs="${myargs} --enable-gcc3"
	else
		myargs="${myargs} --enable-gcc3"

		# We use the dual/multiple install of gcc-3.x if the user
		# have 2.95.3 as base
		#
		# Azarah -- 15 April 2002
		if [ -x /usr/bin/gcc-3.0 ]
		then
			export CC=gcc-3.0
			export CXX=g++-3.0
		elif [ -x /usr/bin/gcc-3.1 ]
		then
			export CC=gcc-3.1
			export CXX=g++-3.1
		else
			die "Cannot find gcc version 3.0 or later"
		fi
	fi

	# Workaround for missing libs with GCC3 (thanks to Debian)
	#
	# Azarah -- 15 April 2002
	mkdir -p ${S}/solver/${MAIN_VER}/unxlngi4.pro/lib
	cp -f /lib/libgcc_s.so.1* ${S}/solver/${MAIN_VER}/unxlngi4.pro/lib
	cp -f /usr/lib/libstdc++.so.3* ${S}/solver/${MAIN_VER}/unxlngi4.pro/lib

	# Do NOT compile with a external STLport, as gcc-2.95.3 users will
	# get linker errors due to the ABI being different (STLport will be
	# compiled with 2.95.3, while OO is compiled with 3.x).
	#
	# Azarah -- 15 April 2002
	cd ${S}/config_office
	rm -f config.cache
	./configure ${myargs} \
		--with-jdk-home=${JAVA_HOME} \
		--with-lang=ENUS \
		--with-x || die

	cd ${S}
	./bootstrap || die "Bootstrap failed!"

	BS=${S}/gentoo-build.csh
	cat >${BS} <<EOT
source LinuxIntelEnv.Set
dmake
EOT
	chmod +x ${BS}
	tcsh ${BS} || die "Build failed!"

	GVERDIR="`grep GVERDIR LinuxIntelEnv.Set |awk '{print $3}'`"
	[ -d ${S}/instsetoo/${GVERDIR} ] || die "Cannot find build dir!"
}

pkg_setup() {

	# This gets in our way ... we MUST use the JDK version, not gcj's
	if [ -f /usr/include/jni.h ]
	then
		mv /usr/include/jni.h /usr/include/jni.h.oo_compile
	fi
}

pkg_preinst() {

	# Restore it if we exiled it before ...
	if [ -f /usr/include/jni.h.oo_compile ]
	then
		mv /usr/include/jni.h.oo_compile /usr/include/jni.h
	fi
}

src_install() {
	# This allows us to change languages without editing the ebuild.
	[ -z "$LANGUAGE" ] && LANGUAGE=01

	GVERDIR="`grep GVERDIR LinuxIntelEnv.Set |awk '{print $3}'`"

	# This next lot is not really tested, and could fail horridly.
	# what I basically do, is generate two scripts with
	# Preston A. Elder's read_ins.pl script.  The first is just
	# the install part extracted, with install location in ${D}.
	# The second is just the db generation, and component registration,
	# which will be done in pkg_postinst() and have the *live*
	# ${ROOT} as target.
	#
	# NOTE: this is just temporary until I can come up with a better
	#       solution (or somebody else).  There is a way to make setup
	#       use a template, but as far as I can tell, the fact that
	#       we use ${D} to install, will nuke component registration.
	#
	# Azarah -- 16 April 2002

	# Generate a install script template
	PREFIX=${D}
	REGCOMP=${S}/solver/${MAIN_VER}/${GVERDIR}/bin/regcomp
	INSTDIR=${S}/instsetoo/${GVERDIR}/${LANGUAGE}/normal
	DESTDIR=${D}${LOC}/OpenOffice-${PV}
	export PREFIX REGCOMP INSTDIR DESTDIR
	${FILESDIR}/${PV}/read_ins.pl >${S}/gentoo-install.sh.orig

	# Generate a register script template
	PREFIX=""
	REGCOMP=${LOC}/OpenOffice-${PV}/program/regcomp
	INSTDIR=${S}/instsetoo/${GVERDIR}/${LANGUAGE}/normal
	DESTDIR=${LOC}/OpenOffice-${PV}
	export PREFIX REGCOMP INSTDIR DESTDIR
	${FILESDIR}/${PV}/read_ins.pl >${S}/gentoo-register.sh.orig

	# Extract our install script
	grep -v "^${S}" ${S}/gentoo-install.sh.orig | grep -v "^echo" > \
		${S}/gentoo-install.sh
	chmod 0755 ${S}/gentoo-install.sh
	${S}/gentoo-install.sh

	# Leave for now ... need for figuring the language selection
	#
	# Azarah -- 16 April 2002
	# 01  03  07  30  31  33  34  39  45  46  48  49  81  82  86  88  90  96

	# Copy regcomp and needed libraries to install directory.  We
	# need them for pkg_postinst component registration.
	cd ${S}/solver/${MAIN_VER}/${GVERDIR}
	mkdir -p ${D}${LOC}/OpenOffice-${PV}/program
	cp bin/regcomp ${D}${LOC}/OpenOffice-${PV}/program

	# Extract our register script
	echo '#!/bin/sh' > ${D}${LOC}/OpenOffice-${PV}/program/gentoo-register.sh
	grep "^echo" ${S}/gentoo-register.sh.orig >> \
		${D}${LOC}/OpenOffice-${PV}/program/gentoo-register.sh
	grep "^LD_LIBRARY_PATH" ${S}/gentoo-register.sh.orig \
		${D}${LOC}/OpenOffice-${PV}/program/gentoo-register.sh
	grep "^${LOC}/OpenOffice-${PV}/program/regcomp" \
		${S}/gentoo-register.sh.orig >> \
		${D}${LOC}/OpenOffice-${PV}/program/gentoo-register.sh
	chmod 0755 ${D}${LOC}/OpenOffice-${PV}/program/gentoo-register.sh
}

pkg_postinst() {
	# Register the components in the live $ROOT
	if [ -x ${ROOT}${LOC}/OpenOffice-${PV}/program/gentoo-register.sh ]
	then
		${ROOT}${LOC}/OpenOffice-${PV}/program/gentoo-register.sh
	fi
}

