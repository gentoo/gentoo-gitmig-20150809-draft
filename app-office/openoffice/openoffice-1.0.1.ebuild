# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-office/openoffice/openoffice-1.0.1.ebuild,v 1.1 2002/09/15 18:12:49 azarah Exp $

# IMPORTANT:  This is extremely alpha!!!

# Notes:
#
#   This will take a HELL of a long time to compile, be warned.
#   According to openoffice.org, it takes approximately 12 hours on a
#   P3/600 with 256mb ram.  And thats where building is its only task.
#
#   It takes about 6 hours on my P4 1.8 with 512mb memory, and the
#   build only needs about 2.1GB of disk space - Azarah.
#
#   You will also need a bucketload of diskspace ... in the order of
#   4-5 gb free to store all the compiled files and installation
#   directories.
#
#   The information on how to build and what is required comes from:
#   http://www.openoffice.org/dev_docs/source/build_linux.html
#   http://tools.openoffice.org/ext_comp.html
#
# Todo:
#
#   Get support going for installing a custom language pack.  Also
#   need to be able to install more than one language pack.

inherit flag-o-matic
# Compile problems with these ...
filter-flags "-funroll-loops"
filter-flags "-fomit-frame-pointer"
replace-flags "-O3" "-O2"
# Needed to stop segfaults in tools
append-flags "-fno-strict-aliasing"

inherit gcc
# We want gcc3 if possible!!!!
export WANT_GCC_3="yes"

inherit virtualx

# Set $ECPUS to amount of processes multiprocessing build should use.
# NOTE:  Setting this too high might cause dmake to segfault!!
#        Setting this to anything but "1" on my pentium4 causes things
#        to segfault :(
[ -z "${ECPUS}" ] && export ECPUS="1"


LOC="/opt"
STLP_VER="4.5.3"

INSTDIR="${LOC}/OpenOffice.org${PV}"
S="${WORKDIR}/oo_${PV}_src"
DESCRIPTION="OpenOffice.org, a full office productivity suite."
SRC_URI="http://ny1.mirror.openoffice.org/${PV}/OOo_${PV}_source.tar.bz2
	http://sf1.mirror.openoffice.org/${PV}/OOo_${PV}_source.tar.bz2
	http://www.stlport.org/archive/STLport-${STLP_VER}.tar.gz
	ftp://ftp.cs.man.ac.uk/pub/toby/gpc/gpc231.tar.Z"
HOMEPAGE="http://www.openoffice.org/"

LICENSE="LGPL-2 | SISSL-1.1"
SLOT="0"
KEYWORDS="x86"

RDEPEND=">=sys-libs/glibc-2.1
	>=sys-devel/perl-5.0
	virtual/x11
	app-arch/zip
	app-arch/unzip
	dev-libs/expat
	>=virtual/jdk-1.3.1"

DEPEND="${RDEPEND}
	app-shells/tcsh"

# fix a bug with tcsh and dircolors
#
# Azarah -- 10 April 2002
export LS_COLORS=""


pkg_setup() {

	if [ "$(gcc-version)" != "3.2" ]
	then
		eerror
		eerror "This build needs gcc-3.2 or later, but due to profile"
		eerror "settings, it cannot DEPEND on it, so please merge it"
		eerror "manually:"
		eerror
		eerror " #  ebuild /usr/portage/sys-devel/gcc/gcc-3.2-r1.ebuild merge"
		eerror
		eerror "Please make sure that you use the latest availible revision of"
		eerror "gcc-3.2.  Thus if there is already a gcc-3.2-r2 out, use this"
		eerror "rather than -r1."
		eerror
		eerror "As of writing, gcc-3.2 seemed to create the most stable builds."
		eerror "Also, because OO is such a complex build, ONLY gcc-3.2 will be"
		eerror "supported!"
		eerror
		die
	fi

	if [ -z "$(echo ${JDK_HOME} | grep "blackdown")" ] && [ "${FORCE_JAVA}" != "yes" ]
	then
		eerror
		eerror "This ebuild has only been tested with the blackdown port of"
		eerror "java.  If you use another java implementation, it could fail"
		eerror "horribly, so please merge the blackdown-jdk and set it as"
		eerror "system VM before proceeding:"
		eerror
		eerror " # emerge blackdown-jdk"
		eerror " # java-config --set-system-vm=blackdown-jdk-1.3.1"
		eerror " # env-update"
		eerror " # source /etc/profile"
		eerror
		eerror "At the time of writing, this was version 1.3.1, so please"
		eerror "adjust the version according to the version installed in"
		eerror "/opt."
		eerror
		eerror "If you however want to test another JDK (not officially supported),"
		eerror "you could do the following:"
		eerror
		eerror " # export FORCE_JAVA=yes"
		eerror
		die
	fi

	ewarn "****************************************************************"
	ewarn " To get this thing to build at all, I had to use less agressive"
	ewarn " CFLAGS and CXXFLAGS.  If this build thus fails, and you edited"
	ewarn " this ebuild at all, or used too agressive compiler flags ..."
	ewarn
	ewarn "   You HAVE been Warned!"
	ewarn
	ewarn "****************************************************************"
}

src_unpack() {

	cd ${WORKDIR}
	unpack OOo_${PV}_source.tar.bz2 gpc231.tar.Z

	# Install gpc
	cd ${WORKDIR}/gpc231
	cp gpc.* ${S}/external/gpc

	cd ${S}

	einfo "Applying patches..."
	# This allows JDK 1.4.0 to be used (Prez)
	patch -p1 < ${FILESDIR}/${PV}/${PN}-1.0.0-configure.patch || die

	# Get OO to build with gcc-3.2's libstdc++.so (Az)
	if [ "$(gcc-version)" = "3.2" ]
	then
		patch -p1 < ${FILESDIR}/${PV}/${P}-use-libstdc++-5.0.0.patch || die
	fi

	# Debian patch to enable build of zipdep
	patch -p1 < ${FILESDIR}/${PV}/${PN}-1.0.0-zipdep-not-found.patch || die

	# Some Debian patches to get the build to use $CC and $CXX,
	# thanks to nidd from #openoffice.org
	patch -p1 < ${FILESDIR}/${PV}/${P}-gcc-version-check.patch || die
	patch -p1 < ${FILESDIR}/${PV}/${P}-set-compiler-vars.patch || die
	patch -p1 < ${FILESDIR}/${PV}/${P}-use-compiler-vars.patch || die
	# Update configure before we do anything else.
	cd ${S}/config_office; autoconf || die; cd ${S}

	# This resolves missing symbols (Debian)
	patch -p1 < ${FILESDIR}/${PV}/${P}-compiler-flags.patch || die

	# Enable ccache and distcc (Debian)
	patch -p1 < ${FILESDIR}/${PV}/${P}-parallel-build.patch || die
	# If $HOME is not set, ccache breaks. (Debian)
	patch -p1 < ${FILESDIR}/${PV}/${P}-dont-unset-home.patch || die

	if [ "$(use ppc)" ]
	then
		# Not sure about this .. PPC guys will have to verify.
		patch -p1 < ${FILESDIR}/${PV}/${P}-bridge-fix-on-PPC.patch || die
	fi

	# Misc Debian patches to fixup build
	patch -p1 < ${FILESDIR}/${PV}/${PN}-1.0.1-no-mozab.patch || die
	echo "moz     moz : NULL" > ${S}/moz/prj/build.lst

	# Misc patches from Mandrake
	patch -p1 < ${FILESDIR}/${PV}/${P}-braindamage.patch || die
	patch -p1 < ${FILESDIR}/${PV}/${P}-fix-asm.patch || die

	# Get OO to use STLport-4.5.3 (Az)
	cp ${DISTDIR}/STLport-${STLP_VER}.tar.gz ${S}/stlport/download || die
	cd ${S}/stlport
	patch -p1 < ${FILESDIR}/${PV}/${P}-use-STLport-4.5.3.patch || die

	# More gcc3 related fixes
	if [ "$(gcc-major-version)" -eq 3 ] && [ "$(gcc-minor-version)" -ne 0 ]
	then
		local incver="$(gcc-version)"
		local minver="$(gcc-minor-version)"
	
		# Fix ./configure for gcc3 (Az)
		perl -pi -e 's|CC --version|CC -dumpversion|g' \
			${S}/config_office/configure
#		perl -pi -e "s|_gccincname1=\"g++-v3\"|_gccincname1=\"g++-v${incver/\.}\"|g" \
#			${S}/config_office/configure

		# Fix header not supporting 3.2 and up (Az)
		perl -pi -e "s|__GNUC_MINOR__ == 0|__GNUC_MINOR__ == ${minver}|g" \
			${S}/cppu/inc/uno/lbnames.h
	fi

	# Now for our optimization flags ...
	perl -pi -e "s|^CFLAGSOPT=.*|CFLAGSOPT=${CFLAGS}|g" \
		${S}/solenv/inc/unxlngi3.mk
	perl -pi -e "s|^CFLAGSOPT=.*|CFLAGSOPT=${CFLAGS}|g" \
		${S}/solenv/inc/unxlngi4.mk

	# Some makefiles are not multiprocess ready (Mandrake)
	cd ${S}; einfo "Fixing makefiles for multiprocess builds..."
	for x in io/source/stm dtrans/source/X11 idlc/source nas zlib toolkit/util \
		comphelper/util padmin/source svtools/util bridges/source/prot_uno \
		ucb/source/ucp/ftpproxy framework/util framework/source/unotypes
	do
		perl -pi -e "s/^(PRJNAME)/MAXPROCESS=1\n\1/" ${x}/makefile.mk
	done
}

get_EnvSet() {

	# Determine what Env file we should be using (Az)
	export LinuxEnvSet="LinuxIntelEnv.Set"
	use sparc && export LinuxEnvSet="LinuxSparcEnv.Set"
	use sparc64 && export LinuxEnvSet="LinuxSparcEnv.Set"
	use ppc && export LinuxEnvSet="LinuxPPCEnv.Set"
	use alpha && export LinuxEnvSet="LinuxAlphaEnv.Set"

	# Get build specific stuff (Az)
	export SOLVER="$(awk '/^setenv UPD / {print $3}' ${LinuxEnvSet})"
	export SOLPATH="$(awk '/^setenv INPATH / {print $3}' ${LinuxEnvSet})"
}

src_compile() {

	local buildcmd=""

	# Setup default compilers (We overide gcc2 if that is default here)
	export CC="$(gcc-getCC)"
	export CXX="$(gcc-getCXX)"

	# Create aliases to normal gcc binary names to make sure we compile
	# everything with the same version of gcc, and avoid possible
	# segfaults.  This is only done if gcc binaries with non standard
	# names are used. (Az)
	[ "${CC}" != "gcc" ] && ln -s $(which ${CC}) ${S}/solenv/bin/gcc
	[ "${CXX}" != "gcc" -a "${CXX}" != "g++" ] && {\
		ln -s $(which ${CXX}) ${S}/solenv/bin/g++
		ln -s $(which ${CXX}) ${S}/solenv/bin/c++
		ln -s $(which ${CXX}) ${S}/solenv/bin/cpp
	}

	# Enable distcc for this build (Az)
	if [ "${FEATURES/-distcc/}" = "${FEATURES}" -a \
	     "${FEATURES/distcc/}" != "${FEATURES}" -a \
		 -x /usr/bin/distcc ]
	then
		# Do not bump ECPUS if the user did not touch it, as currently
		# it -PP do not work properly (segfaulting). (Az)
		[ "$(echo ${DISTCC_HOSTS} | wc -w)" -gt 1 -a "${ECPUS}" -qt 1 ] && \
			export ECPUS="$(echo ${DISTCC_HOSTS} | wc -w)"

		export CC="distcc ${CC}"
		export CXX="distcc ${CXX}"
	fi

	# Enable ccache for this build (Az)
	if [ "${FEATURES/-ccache/}" = "${FEATURES}" -a \
	     "${FEATURES/ccache/}" != "${FEATURES}" -a \
		 -d /usr/bin/ccache -a -x /usr/bin/ccache/ccache ]
	then
		# Build uses its own env with $PATH, etc, so
		# we take the easy way out. (Az)
		export CC="/usr/bin/ccache/ccache ${CC}"
		export CXX="/usr/bin/ccache/ccache ${CXX}"
	fi
	
	# Do NOT compile with a external STLport, as gcc-2.95.3 users will
	# get linker errors due to the ABI being different (STLport will be
	# compiled with 2.95.3, while OO is compiled with 3.x). (Az)
	einfo "Configuring OpenOffice.org..."
	cd ${S}/config_office
	rm -f config.cache
	./configure --enable-gcc3 \
		--with-jdk-home=${JAVA_HOME} \
		--with-lang=ENUS \
		--with-x || die
	
	cd ${S}
	get_EnvSet
	
	# Workaround for missing libs with GCC3 (thanks to Debian) (Az)
	if [ "$(gcc-major-version)" -eq 3 ]
	then
		einfo "Installing GCC related libs..."

		mkdir -p ${S}/solver/${SOLVER}/${SOLPATH}/lib

		cd ${S}/solver/${SOLVER}/${SOLPATH}/lib
		cp $(gcc-libpath)/libstdc++.so.$(gcc-libstdcxx-major-version)* . || \
			die "Could not copy gcc-libs!"
		cp $(gcc-libpath)/libgcc_s.so* . || die "Could not copy gcc-libs!"
		cd ${S}
	fi

	# Do not include /usr/include in header search path, and
	# same thing for internal gcc include dir, as gcc3 handles
	# it correctly by default! (Az)
	perl -pi -e "s| -I/usr/include||g" ${LinuxEnvSet}
#	perl -pi -e "s| -I$(gcc-libpath)/include||g" ${LinuxEnvSet}

	# Should the build use multiprocessing?
	# We use build.pl directly, as dmake tends to segfault. (Az)
	if [ "${ECPUS}" -gt 1 ]
	then
		buildcmd="${S}/solenv/bin/build.pl -all -PP${ECPUS} product=full"
	else
		buildcmd="${S}/solenv/bin/build.pl -all product=full"
	fi
		
	einfo "Bootstrapping OpenOffice.org..."
	# Get things ready for bootstrap (Az)
	chmod 0755 ${S}/solenv/bin/*.pl
	mkdir -p ${S}/solver/${SOLVER}/${SOLPATH}/inc
	touch ${S}/solver/${SOLVER}/${SOLPATH}/inc/minormkchanged.flg
	# Bootstrap ...
	./bootstrap
	
	einfo "Building OpenOffice.org..."
	# Setup virtualmake
	export maketype="tcsh"
	echo "source ${S}/${LinuxEnvSet} && cd ${S}/instsetoo && ${buildcmd}" > build.tcsh
	# Build needs X to compile! (Az)
	virtualmake build.tcsh || die "Build failed!"

	[ -d ${S}/instsetoo/${SOLPATH} ] || die "Cannot find build directory!"
}

src_install() {

	# This allows us to change languages without editing the ebuild.
	#
	#   languages1="ENUS,FREN,GERM,SPAN,ITAL,DTCH,PORT,SWED,POL,RUSS"
	#   languages2="DAN,GREEK,TURK,CHINSIM,CHINTRAD,JAPN,KOREAN,CZECH,CAT"
	#
	# Supported languages for localized help files
	#
	#   helplangs="ENUS,FREN,GERM,SPAN,ITAL,SWED"
	#
	[ -z "${LANGUAGE}" ] && LANGUAGE=01

	get_EnvSet
	
	# The install part should now be relatively OK compared to
	# what it was.  Basically we use autoresponse files to install
	# unattended, running under a Xvfb if needed.  Afterwards we
	# just cleanout ${D} from the registry, etc.  This way we
	# do not need pre-generated registry, and also fixes some weird
	# bugs related to the old way we did things.
	#
	# <azarah@gentoo.org> (9 Sep 2002)

	# Autoresponse file for main installation
	cat > ${T}/rsfile-global <<-"END_RS"
		[ENVIRONMENT]
		INSTALLATIONMODE=INSTALL_NETWORK
		INSTALLATIONTYPE=STANDARD
		DESTINATIONPATH=<destdir>
		OUTERPATH=
		LOGFILE=
		LANGUAGELIST=<LANGUAGE>

		[JAVA]
		JavaSupport=preinstalled_or_none
	END_RS
	
	# Autoresponse file for user isntallation
	cat > ${T}/rsfile-local <<-"END_RS"
		[ENVIRONMENT]
		INSTALLATIONMODE=INSTALL_WORKSTATION
		INSTALLATIONTYPE=WORKSTATION
		DESTINATIONPATH=<home>/.openoffice/<pv>

		[JAVA]
		JavaSupport=none
	END_RS

	# Fixing install location in response file
	sed -e "s|<destdir>|${D}${INSTDIR}|" \
		${T}/rsfile-global > ${T}/autoresponse

	einfo "Installing OpenOffice.org into build root..."
	dodir ${INSTDIR}
	cd ${S}/instsetoo/${SOLPATH}/${LANGUAGE}/normal
	# Setup virtualmake
	export maketype="./setup"
	# We need X to install...
	virtualmake "-v -r:${T}/autoresponse"

	echo
	einfo "Removing build root from registy..."
	# Remove totally useless stuff.
	rm -f ${D}${INSTDIR}/program/{setup.log,sopatchlevel.sh}
	# Remove build root from registry and co
	egrep -rl "${D}" ${D}${INSTDIR}/* | \
		xargs -i perl -pi -e "s|${D}||g" {} || :

	einfo "Fixing permissions..."
	# Fix permissions
	find ${D}${INSTDIR}/ -type f -exec chmod a+r {} \;
	chmod a+x ${D}${INSTDIR}/share/config/webcast/*.pl

	# Fix symlinks
	for x in "soffice program/spadmin" \
		"program/setup setup" \
		"program/spadmin spadmin"
	do
		dosym $(echo ${x} | awk '{print $1}') \
			${INSTDIR}/$(echo ${x} | awk '{print $2}')
	done

	# Install user autoresponse file
	insinto /etc/openoffice
	sed -e "s|<pv>|${PV}|g" ${T}/rsfile-local > ${T}/autoresponse.conf
	doins ${T}/autoresponse.conf
	
	# Install wrapper script
	exeinto /usr/bin
	sed -e "s|<pv>|${PV}|g" \
		${FILESDIR}/${PV}/ooffice-wrapper > ${T}/ooffice
	doexe ${T}/ooffice
	# Component symlinks
	dosym ooffice /usr/bin/oocalc
	dosym ooffice /usr/bin/oodraw
	dosym ooffice /usr/bin/ooimpress
	dosym ooffice /usr/bin/oomath
	dosym ooffice /usr/bin/oowriter
	dosym ooffice /usr/bin/oosetup
	dosym ooffice /usr/bin/oopadmin

	einfo "Installing Menu shortcuts (need \"gnome\" or \"kde\" in USE)..."
	if [ -n "`use gnome`" ]
	then
		insinto /usr/share/gnome/apps/OpenOffice.org
		# Install the files needed for the catagory
		doins ${D}${INSTDIR}/share/gnome/net/.directory
		doins ${D}${INSTDIR}/share/gnome/net/.order
		
		for x in ${D}${INSTDIR}/share/gnome/net/*.desktop
		do
			# We have to handle setup differently
			perl -pi -e "s:${INSTDIR}/program/setup:/usr/bin/oosetup:g" ${x}
			# Now fix the rest
			perl -pi -e "s:${INSTDIR}/program/s:/usr/bin/oo:g" ${x}
			doins ${x}
		done
	fi

	if [ -n "`use kde`" ]
	then
		local kdeloc="${D}${INSTDIR}/share/kde/net/applnk/OpenOffice.org${PV}"
	
		# Portage do not work with the space ..
		mv ${D}${INSTDIR}/share/kde/net/applnk/OpenOffice.org\ ${PV} ${kdeloc}
		
		insinto /usr/share/applnk/OpenOffice.org
		# Install the files needed for the catagory
		doins ${kdeloc}/.directory
		doins ${kdeloc}/.order
		dodir /usr/share
		# Install the icons and mime info
		cp -a ${D}${INSTDIR}/share/kde/net/mimelnk/share/* ${D}/usr/share
		
		for x in ${kdeloc}/*.desktop
		do
			# We have to handle setup differently
			perl -pi -e "s:${INSTDIR}/program/setup:/usr/bin/oosetup:g" ${x}
			# Now fix the rest
			perl -pi -e "s:${INSTDIR}/program/s:/usr/bin/oo:g" ${x}
			doins ${x}
		done
	fi

	# Unneeded, as they get installed into /usr/share...
	rm -rf ${D}${INSTDIR}/share/{cde,gnome,kde}

	# Make sure these do not get nuked.
	keepdir ${INSTDIR}/user/config/registry/instance/org/openoffice/{Office,ucb}
	keepdir ${INSTDIR}/user/psprint/{driver,fontmetric}
	keepdir ${INSTDIR}/user/{autocorr,backup,plugin,store,temp,template}
}

pkg_preinst() {

	# The one with OO-1.0.0 was not valid
	if [ -f ${ROOT}/etc/openoffice/autoresponse.conf ]
	then
		rm -f ${ROOT}/etc/openoffice/autoresponse.conf
	fi
}

pkg_postinst() {

	einfo "******************************************************************"
	einfo " To start OpenOffice.org, run:"
	einfo
	einfo "   $ ooffice"
	einfo
	einfo " Also, for individual components, you can use any of:"
	einfo
	einfo "   oocalc, oodraw, ooimpress, oomath or oowriter"
	einfo
	einfo "******************************************************************"
}   

