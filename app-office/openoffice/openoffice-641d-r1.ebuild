# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Authors: Preston A. Elder <prez@goth.net>, Martin Schlemmer <azarah@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-office/openoffice/openoffice-641d-r1.ebuild,v 1.1 2002/05/03 22:55:20 azarah Exp $

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
# Some kind of install process.  Works mostly, but the xml registry
# needs to be updated via a script or some program, not a tarball.

LOC="/opt"
MAIN_VER="`echo ${PV} |sed -e "s:[a-z]::g"`"
S="${WORKDIR}/oo_${PV}_src"
DESCRIPTION="OpenOffice productivity suite"
SRC_URI="http://ny1.mirror.openoffice.org/${PV}/oo_${PV}_src.tar.bz2
	http://sf1.mirror.openoffice.org/${PV}/oo_${PV}_src.tar.bz2
	ftp://ftp.cs.man.ac.uk/pub/toby/gpc/gpc231.tar.Z
	http://www.ibiblio.org/gentoo/distfiles/${PN}-${PV}-registry.tbz2"
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
	unpack oo_${PV}_src.tar.bz2 gpc231.tar.Z
	cd ${WORKDIR}/gpc231
	cp gpc.* ${S}/external/gpc
	cd ${S}

	# This allows JDK 1.4.0 to be used
	patch -p1 <${FILESDIR}/${PV}/${P}-configure.patch || die

	# Debian patches to fix build problems with gcc-3.0.4
	#
	# Azarah -- 23 April 2002
	patch -p1 <${FILESDIR}/${PV}/${P}-exception-sprecs.patch || die
	patch -p1 <${FILESDIR}/${PV}/${P}-clk-tck-gcc-3.patch || die
	patch -p1 <${FILESDIR}/${PV}/${P}-define-XSetIMValues.patch || die
	patch -p1 <${FILESDIR}/${PV}/${P}-use-libstdc++-3.0.4.patch || die
	patch -p1 <${FILESDIR}/${PV}/${P}-class-SwpHtStart-SAR.patch || die


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

	# Misc Debian patches to fixup build
	#
	# Azarah -- 22 April 2002
#	patch -p1 <${FILESDIR}/${PV}/${P}-no-mozab.patch || die
	patch -p1 <${FILESDIR}/${PV}/${P}-remove-libstdc-from-scp.patch || die

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

	tcsh -c "source LinuxIntelEnv.Set; dmake" || die "Build failed!"

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
	# what I basically do, is generate three scripts with
	# Preston A. Elder's read_ins.pl script.  The first is just
	# the install part extracted, with install location in ${D}.
	# The second is just the db generation, and third is component
	# registration, which will be done in pkg_postinst() and have
	# the *live* ${ROOT} as target.
	#
	# NOTE: this is just temporary until I can come up with a better
	#       solution (or somebody else).  There is a way to make setup
	#       use a template, but as far as I can tell, the fact that
	#       we use ${D} to install, will nuke component registration.
	#
	# Azarah -- 16 April 2002

	# Generate a install script
	PREFIX=${D}
	REGCOMP=${S}/solver/${MAIN_VER}/${GVERDIR}/bin/regcomp
	INSTDIR=${S}/instsetoo/${GVERDIR}/${LANGUAGE}/normal
	DESTDIR=${D}${LOC}/OpenOffice-${PV}
	export PREFIX REGCOMP INSTDIR DESTDIR
	export RUNARGS="install"
	${FILESDIR}/${PV}/read_ins.pl >${S}/gentoo-install.sh
	chmod 0755 ${S}/gentoo-install.sh

	# Generate createdb and register scripts
	PREFIX=""
	REGCOMP=${LOC}/OpenOffice-${PV}/program/regcomp
	INSTDIR=${S}/instsetoo/${GVERDIR}/${LANGUAGE}/normal
	DESTDIR=${LOC}/OpenOffice-${PV}
	export PREFIX REGCOMP INSTDIR DESTDIR
	export RUNARGS="register"
	${FILESDIR}/${PV}/read_ins.pl >${S}/gentoo-register.sh || die
	chmod 0755 ${S}/gentoo-register.sh
	export RUNARGS="createdb"
	${FILESDIR}/${PV}/read_ins.pl >${S}/gentoo-createdb.sh || die
	chmod 0755 ${S}/gentoo-createdb.sh

	# Install to ${D}
	${S}/gentoo-install.sh || die "Failed to install data to ${D}!"
		
	# Leave for now ... need for figuring the language selection
	#
	# Azarah -- 16 April 2002
	# 01  03  07  30  31  33  34  39  45  46  48  49  81  82  86  88  90  96

	# Copy regcomp and needed libraries to install directory.  We
	# need them for pkg_postinst component registration.
	cd ${S}/solver/${MAIN_VER}/${GVERDIR}
	mkdir -p ${D}${LOC}/OpenOffice-${PV}/program
	cp bin/regcomp ${D}${LOC}/OpenOffice-${PV}/program

	# NOTE!!!! We need to fix the registry for network install somehow.
	#
	# Crappy solution for now:
	# Unpack the registry needed for NETWORK installation.
	# This my need to be updated for future versions of OO.
	# Install binary with "./setup -net" to generate.
	cd ${D}${LOC}/OpenOffice-${PV}/share/config/registry
	rm -rf *
	tar -jxpf ${DISTDIR}/${PN}-${PV}-registry.tbz2 || \
		die "Could not unpack registry!"
	# Fix paths
	cd ${D}${LOC}/OpenOffice-${PV}/share/config/registry/instance/org/openoffice/Office
	cp Common.xml Common.xml.orig
	sed -e "s:/opt/OpenOffice.org641:${LOC}/OpenOffice-${PV}:g" \
		Common.xml.orig >Common.xml
	rm -f Common.xml.orig

	# Generate ISO resource files.
	cd ${D}${LOC}/OpenOffice-${PV}/program/resource
	for x in ooo*.res
	do
		cp ${x} ${x/ooo/iso}
	done

	# Create the global fonts.dir file
	cd ${D}${LOC}/OpenOffice-${PV}/share/fonts/truetype
	cp -f fonts.dir  fonts_dir.global

	# Create misc directories
	cd ${D}${LOC}/OpenOffice-${PV}
	mkdir -p user/config/registry/instance/org/openoffice/{Office,ucb}
	mkdir -p user/psprint/{driver,fontmetric}
	mkdir -p user/{autocorr,backup,plugin,store,temp,template}

	# Move the register and createdb scripts to ${D}
	cp -f ${S}/gentoo-register.sh ${D}${LOC}/OpenOffice-${PV}/program
	cp -f ${S}/gentoo-createdb.sh ${D}${LOC}/OpenOffice-${PV}/program
}

pkg_postinst() {
	if [ "${ROOT}" = "/" ]
	then
		for x in bootstraprc configmgrrc instdb.ins sofficerc unorc
		do
			if [ -e ${LOC}/OpenOffice-${PV}/program/${x} ]
			then
				rm -f ${LOC}/OpenOffice-${PV}/program/${x} >/dev/null
			fi
		done
		${LOC}/OpenOffice-${PV}/program/gentoo-createdb.sh || die
		echo ">>> Registering components (this may take a few minutes)..."
		${LOC}/OpenOffice-${PV}/program/gentoo-register.sh &>/dev/null || die
	fi

	# Make sure these do not get nuked.
	cd ${ROOT}${LOC}/OpenOffice-${PV}
	mkdir -p user/config/registry/instance/org/openoffice/{Office,ucb}
	mkdir -p user/psprint/{driver,fontmetric}
	mkdir -p user/{autocorr,backup,plugin,store,temp,template}
}

