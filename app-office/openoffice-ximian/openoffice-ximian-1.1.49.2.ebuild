# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/openoffice-ximian/openoffice-ximian-1.1.49.2.ebuild,v 1.2 2004/01/14 10:48:46 pauldv Exp $

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

inherit flag-o-matic eutils gcc virtualx

# Compile problems with these ...
filter-flags "-funroll-loops"
filter-flags "-fomit-frame-pointer"
filter-flags "-fprefetch-loop-arrays"
append-flags "-fno-strict-aliasing"
replace-flags "-O3" "-O2"
replace-flags "-Os" "-O2"

# We want gcc3 if possible!!!!
export WANT_GCC_3="yes"

# Set $ECPUS to amount of processes multiprocessing build should use.
# NOTE:  Setting this too high might cause dmake to segfault!!
#        Setting this to anything but "1" on my pentium4 causes things
#        to segfault :(
[ -z "${ECPUS}" ] && export ECPUS="1"

OO_VER=1.1.0
PATCHLEVEL=OOO_1_1_0
ICON_VER=OOO_1_1-7
INSTDIR="/opt/Ximian-OpenOffice"
PATCHDIR=${WORKDIR}/ooo-build-${PV}
ICONDIR=${WORKDIR}/ooo-icons-${ICON_VER}
S="${WORKDIR}/oo_${OO_VER/1.1.0/1.1}_src"
DESCRIPTION="Ximian-ized version of OpenOffice.org, a full office productivity suite."
SRC_URI="mirror://openoffice/stable/${OO_VER}/OOo_${OO_VER}_source.tar.bz2
	http://ooo.ximian.com/packages/${PATCHLEVEL}/ooo-build-${PV}.tar.gz
	http://ooo.ximian.com/packages/ooo-icons-${ICON_VER}.tar.gz"

HOMEPAGE="http://ooo.ximian.com"

LICENSE="LGPL-2 | SISSL-1.1"
SLOT="0"
KEYWORDS="~x86"
IUSE="gnome kde"

RDEPEND=">=sys-libs/glibc-2.1
	!=sys-libs/glibc-2.3.1*
	>=dev-lang/perl-5.0
	>=x11-libs/gtk+-2.0
	>=gnome-base/libgnome-2.2
	>=gnome-base/gnome-vfs-2.0
	>=net-print/libgnomecups-0.1.4
	>=net-print/gnome-cups-manager-0.16
	>=dev-libs/libxml2-2.0
	>=media-libs/libart_lgpl-2.3.13
	>=x11-libs/startup-notification-0.5
	media-fonts/ttf-bitstream-vera
	media-libs/fontconfig
	media-gfx/imagemagick
	media-libs/libpng
	sys-devel/flex
	sys-devel/bison
	virtual/x11
	app-arch/zip
	app-arch/unzip
	dev-libs/expat
	virtual/lpr
	ppc? ( >=sys-libs/glibc-2.2.5-r7
	>=sys-devel/gcc-3.2.1 )
	>=media-libs/freetype-2.1.4"

DEPEND="${RDEPEND}
	app-shells/tcsh
	!app-office/openoffice-bin
	!app-office/openoffice
	>=sys-apps/findutils-4.1.20-r1
	dev-libs/libxslt
	net-ftp/curl
	!dev-util/dmake"

pkg_setup() {

	ewarn "****************************************************************"
	ewarn " It is important to note that OpenOffice.org is a very fragile  "
	ewarn " build when it comes to CFLAGS.  A number of flags have already "
	ewarn " been filtered out.  If you experience difficulty merging this  "
	ewarn " package and use agressive CFLAGS, lower the CFLAGS and try to  "
	ewarn " merge again.					               "
	ewarn "****************************************************************"

	set_languages

}


set_languages () {

	if [ -z "$LANGUAGE" ]; then
		LANGUAGE=01
	fi

	case "$LANGUAGE" in
		01 | ENUS ) LANGNO=01; LANGNAME=ENUS; LFULLNAME="US English (default)"
			;;
		03 | PORT ) LANGNO=03; LANGNAME=PORT; LFULLNAME=Portuguese
			;;
		07 | RUSS ) LANGNO=07; LANGNAME=RUSS; LFULLNAME=Russian
			;;
		30 | GREEK ) LANGNO=30; LANGNAME=GREEK; LFULLNAME=Greek
			;;
		31 | DTCH ) LANGNO=31; LANGNAME=DTCH; LFULLNAME=Dutch
			;;
		33 | FREN ) LANGNO=33; LANGNAME=FREN; LFULLNAME=French
			;;
		34 | SPAN ) LANGNO=34; LANGNAME=SPAN; LFULLNAME=Spanish
			;;
		35 | FINN ) LANGNO=35; LANGNAME=FINN; LFULLNAME=Finnish
			;;
		37 | CAT ) LANGNO=37; LANGNAME=CAT; LFULLNAME=Catalan
			;;
		39 | ITAL ) LANGNO=39; LANGNAME=ITAL; LFULLNAME=Italian
			;;
		42 | CZECH ) LANGNO=42; LANGNAME=CZECH; LFULLNAME=Czech
			;;
		43 | SLOVAK ) LANGNO=43; LANGNAME=SLOVAK; LFULLNAME=Slovak
			;;
		45 | DAN ) LANGNO=45; LANGNAME=DAN; LFULLNAME=Danish
			;;
		46 | SWED ) LANGNO=46; LANGNAME=SWED; LFULLNAME=Swedish
			;;
		48 | POL ) LANGNO=48; LANGNAME=POL; LFULLNAME=Polish
			;;
		49 | GER ) LANGNO=49; LANGNAME=GER; LFULLNAME=German
			;;
		55 | PORTBR ) LANGNO=55; LANGNAME=PORTBR; LFULLNAME="Portuguese brazilian"
			;;
		66 | THAI ) LANGNO=66; LANGNAME=THAI; LFULLNAME=Thai
			;;
		77 | ESTONIAN ) LANGNO=77; LANGNAME=ESTONIAN; LFULLNAME=Estonian
			;;
		81 | JAPN ) LANGNO=81; LANGNAME=JAPN; LFULLNAME="Japanese"
			;;
		82 | KOREAN ) LANGNO=82; LANGNAME=KOREAN; LFULLNAME=Korean
			;;
		86 | CHINSIM ) LANGNO=86; LANGNAME=CHINSIM; LFULLNAME="Simplified Chinese (PRC)"
			;;
		88 | CHINTRAD ) LANGNO=88; LANGNAME=CHINTRAD; LFULLNAME="Traditional Chinese (taiwan)"
			;;
		90 | TURK ) LANGNO=90; LANGNAME=TURK; LFULLNAME=Turkish
			;;
		91 | HINDI ) LANGNO=91; LANGNAME=HINDI; LFULLNAME=Hindi
			;;
		96 | ARAB ) LANGNO=96; LANGNAME=ARAB; LFULLNAME=Arabic
			;;
		97 | HEBREW ) LANGNO=97; LANGNAME=HEBREW; LFULLNAME=Hebrew
			;;
		* )
			eerror "Unknown LANGUAGE setting!"
			eerror
			eerror "Known LANGUAGE settings are:"
			eerror "  ENUS | PORT | RUSS | GREEK | DTCH | FREN | SPAN | FINN | CAT | ITAL |"
			eerror "  CZECH | SLOVAK | DAN | SWED | POL | GER | PORTBR | THAI | ESTONIAN |"
			eerror "  JAPN | KOREAN | CHINSIM | CHINTRAD | TURK | HINDI | ARAB | HEBREW"
			die
			;;
	esac
}

oo_setup() {

	unset LANGUAGE
	unset LANG

	export NEW_GCC="0"

	if [ -x /usr/sbin/gcc-config ]
	then
		# Do we have a gcc that use the new layout and gcc-config ?
		if /usr/sbin/gcc-config --get-current-profile &> /dev/null
		then
			export NEW_GCC="1"
			export GCC_PROFILE="$(/usr/sbin/gcc-config --get-current-profile)"

			# Just recheck gcc version ...
			if [ "$(gcc-version)" != 3.2 -a "$(gcc-version)" != "3.3" ]
			then
				# See if we can get a gcc profile we know is proper ...
				if /usr/sbin/gcc-config --get-bin-path ${CHOST}-3.2.1 &> /dev/null
				then
					export PATH="$(/usr/sbin/gcc-config --get-bin-path ${CHOST}-3.2.1):${PATH}"
					export GCC_PROFILE="${CHOST}-3.2.1"
				else
					eerror "This build needs gcc-3.2.1 or later!"
					eerror
					eerror "Use gcc-config to change your gcc profile:"
					eerror
					eerror "  # gcc-config $CHOST-3.2.1"
					eerror
					eerror "or whatever gcc version is relevant."
					die
				fi
			fi
		fi
	fi

}

src_unpack() {

	oo_setup

	cd ${WORKDIR}
	unpack OOo_${OO_VER}_source.tar.bz2 ooo-build-${PV}.tar.gz ooo-icons-${ICON_VER}.tar.gz

	#Still needed: The STLport patch
	cd ${S}
	rm stlport/STLport-4.5.3.patch
	epatch ${FILESDIR}/${OO_VER}/newstlportfix.patch

	#Fix compilation with gcc 3.2.x	
	epatch ${FILESDIR}/${OO_VER}/config.patch

	#Fix nptl compile issues
	epatch ${FILESDIR}/${OO_VER}/nptl.patch

	#Additional patch for Kernel 2.6
	epatch ${FILESDIR}/${OO_VER}/openoffice-1.1.0-linux-2.6-fix.patch

	if [ ${ARCH} = "sparc" ]; then
		epatch ${FILESDIR}/${OO_VER}/openoffice-1.1.0-sparc64-fix.patch
	fi

	einfo "Applying Ximian OO.org Patches"
	${PATCHDIR}/patches/apply.pl ${PATCHDIR}/patches/${PATCHLEVEL} ${S} -f --distro=Ximian || die "Ximian patches failed"

	einfo "Installing / Scaling Icons"
	${PATCHDIR}/bin/scale-icons ${S}
	cp -avf ${ICONDIR}/* ${S}

	einfo "Munging font mappings ..."
	${PATCHDIR}/bin/font-munge ${S}/officecfg/registry/data/org/openoffice/VCL.xcu
	echo "done munging fonts."

	# Now for our optimization flags ...
	perl -pi -e "s|^CFLAGSOPT=.*|CFLAGSOPT=${CFLAGS}|g" \
		${S}/solenv/inc/unxlngi3.mk
	perl -pi -e "s|^CFLAGSOPT=.*|CFLAGSOPT=${CFLAGS}|g" \
		${S}/solenv/inc/unxlngi4.mk

	# Some makefiles are not multiprocess ready (Mandrake)
	cd ${S}; einfo "Fixing makefiles for multiprocess builds..."
	for x in io/source/stm dtrans/source/X11 idlc/source nas zlib toolkit/util \
		comphelper/util padmin/source svtools/util bridges/source/prot_uno \
		framework/util framework/source/unotypes
	do
		perl -pi -e "s/^(PRJNAME)/MAXPROCESS=1\n\1/" ${x}/makefile.mk
	done

	#Do our own branding by setting gentoo linux as the vendor
	sed -i -e "s,\(//\)\(.*\)\(my company\),\2Gentoo Linux," ${S}/offmgr/source/offapp/intro/ooo.src
}

get_EnvSet() {

	# Determine what Env file we should be using (Az)
	export LinuxEnvSet="LinuxIntelEnv.Set.sh"
	use sparc && export LinuxEnvSet="LinuxSparcEnv.Set.sh"
	use sparc64 && export LinuxEnvSet="LinuxSparcEnv.Set.sh"
	use ppc && export LinuxEnvSet="LinuxPPCEnv.Set.sh"
	use alpha && export LinuxEnvSet="LinuxAlphaEnv.Set.sh"

	# Get build specific stuff (Az)
	export SOLVER="$(awk '/^UPD=/ {gsub(/\"/, ""); gsub(/UPD=/, ""); print $0}' ${LinuxEnvSet})"
	export SOLPATH="$(awk '/^INPATH=/ {gsub(/\"/, ""); gsub(/INPATH=/, ""); print $0}' ${LinuxEnvSet})"

}

src_compile() {

	if [ "$(gcc-version)" == "3.2" ]; then
		einfo "You use a buggy gcc, so replacing -march=pentium4 with -march=pentium3"
		replace-flags "-march=pentium4" "-march=pentium3 -mcpu=pentium4"
	fi

	addpredict /bin
	addpredict /root/.gconfd
	local buildcmd=""

	set_languages

	oo_setup

	# Setup default compilers (We overide gcc2 if that is default here)
	export CC="$(gcc-getCC)"
	export CXX="$(gcc-getCXX)"

	# Enable new ccache for this build
	if [ "${FEATURES/-ccache/}" = "${FEATURES}" -a \
	     "${FEATURES/ccache/}" != "${FEATURES}" -a \
	     -x /usr/bin/ccache -a ! -d /usr/bin/ccache ]
	then
		einfo "We're using ccache for this build..."
		# Build uses its own env with $PATH, etc, so
		# we take the easy way out. (Az)
		export CC="/usr/bin/ccache ${CC}"
		export CXX="/usr/bin/ccache ${CXX}"
	fi

	# Enable distcc for this build (Az)
	if [ "${FEATURES/-distcc/}" = "${FEATURES}" -a \
	     "${FEATURES/distcc/}" != "${FEATURES}" -a \
		 -x /usr/bin/distcc ]
	then
		einfo "We're using distcc for this build..."
		# Do not bump ECPUS if the user did not touch it, as currently
		# it -PP do not work properly (segfaulting). (Az)
		[ "$(echo ${DISTCC_HOSTS} | wc -w)" -gt 1 -a "${ECPUS}" -qt 1 ] && \
			export ECPUS="$(echo ${DISTCC_HOSTS} | wc -w)"

		export CC="distcc ${CC}"
		export CXX="distcc ${CXX}"
	fi

	# dmake security patch
	cd ${S}/dmake
	autoconf || die

	# Do NOT compile with a external STLport, as gcc-2.95.3 users will
	# get linker errors due to the ABI being different (STLport will be
	# compiled with 2.95.3, while OO is compiled with 3.x). (Az)
	einfo "Configuring OpenOffice.org with language support for ${LFULLNAME}..."
	cd ${S}/config_office
	rm -f config.cache
	autoconf
	./configure \
		--enable-libart \
		--enable-libsn \
		--enable-crashdump=no \
		--with-lang=ENUS,${LANGNAME} \
		--without-fonts \
		--disable-rpath \
		--enable-fontconfig \
		--with-system-zlib \
		--with-system-freetype \
		--with-system-curl \
		--disable-java || die

	cd ${S}
	get_EnvSet

	# Build as minimal as possible
	export BUILD_MINIMAL="${LANGNO}"

	# Do not include /usr/include in header search path, and
	# same thing for internal gcc include dir, as gcc3 handles
	# it correctly by default! (Az)
	perl -pi -e "s| -I/usr/include||g" ${LinuxEnvSet}
#	perl -pi -e "s| -I$(gcc-libpath)/include||g" ${LinuxEnvSet}

	if [ "${NEW_GCC}" -eq "1" ]
	then
		local gcc_path="$(/usr/sbin/gcc-config --get-bin-path ${GCC_PROFILE})"

		# Setup path for new gcc layout in $LinuxEnvSet, else the build
		# environment will not find gcc ... (Az)
		perl -pi -e "s|PATH \.:\$SOLARVER|PATH \.:${gcc_path}:\$SOLARVER|" ${LinuxEnvSet}
		# New builds start quoting stuff ...
		perl -pi -e "s|PATH \"\.:\$SOLARVER|PATH \"\.:${gcc_path}:\$SOLARVER|" ${LinuxEnvSet}
	fi

	# Should the build use multiprocessing?
	if [ "${ECPUS}" -gt 1 ]
	then
		buildcmd="${S}/solenv/bin/build.pl --all -P ${ECPUS} product=full --dlv_switch link"
	else
		buildcmd="${S}/solenv/bin/build.pl --all product=full --dlv_switch link"
	fi

	if [ -z "$(grep 'CCCOMP' ${S}/${LinuxEnvSet})" ]
	then
		# Set CCCOMP and CXXCOMP.  This is still needed for STLport
		export CCCOMP=${CC}
		export CXXCOMP=${CXX}
	fi

	if [ "$(gcc-major-version)" -eq 3 ]
	then
		mkdir -p ${S}/solver/${SOLVER}/${SOLPATH}/{lib,inc}

		einfo "Installing GCC related libs..."
		# Workaround for missing libs with GCC3 (thanks to Debian) (Az)
		cd ${S}/solver/${SOLVER}/${SOLPATH}/lib
		cp $(gcc-libpath)/libstdc++.so.$(gcc-libstdcxx-major-version)* . || \
			die "Could not copy gcc-libs!"
		cp $(gcc-libpath)/libgcc_s.so* . || die "Could not copy gcc-libs!"
		cd ${S}
	fi

	einfo "Bootstrapping OpenOffice.org..."
	# Get things ready for bootstrap (Az)
	chmod 0755 ${S}/solenv/bin/*.pl
	mkdir -p ${S}/solver/${SOLVER}/${SOLPATH}/inc
	touch ${S}/solver/${SOLVER}/${SOLPATH}/inc/minormkchanged.flg
	# Bootstrap ...
	./bootstrap

	if [ "$(gcc-major-version)" -eq 3 ]
	then
		local LIBFILE="$(readlink `gcc-libpath`/libstdc++.so.`gcc-libstdcxx-major-version`)"
		local LIBVERSION="$(echo ${LIBFILE} | sed -e 's|libstdc++\.so\.||g')"
		# Get this beast to use the right version of libstdc++ ... (Az)
		echo "LIBSTDCPP3:=${LIBVERSION}" >> \
			${S}/solver/${SOLVER}/${SOLPATH}/inc/comp_ver.mk
		cd ${S}
	fi

	einfo "Building OpenOffice.org..."
	# Setup virtualmake
	export maketype="sh"
	echo "source ${S}/${LinuxEnvSet} && cd ${S}/instsetoo && ${buildcmd}" > build.sh
	# Build needs X to compile! (Az)
	virtualmake build.sh || die "Build failed!"

#	einfo "Building Language Pack"
	# Setup virtualmake
#	export maketype="sh"
#	echo "source ${S}/${LinuxEnvSet} && cd ${S}/instsetoo && ${buildcmd} --from instsetoo -- instsetext=${LANGNO}" > buildlang.sh
	# Build needs X to compile! (Az)
#	virtualmake buildlang.sh || die "Build failed!"

	[ -d ${S}/instsetoo/${SOLPATH} ] || die "Cannot find build directory!"
}

src_install() {

	# Sandbox issues; bug #11838
	addpredict "/user"
	addpredict "/share"
	addpredict "/dev/dri"
	addpredict "/usr/bin/soffice"
	addpredict "/pspfontcache"

	# This allows us to change languages without editing the ebuild.
	#
	#   languages1="ENUS,FREN,GERM,SPAN,ITAL,DTCH,PORT,SWED,POL,RUSS"
	#   languages2="DAN,GREEK,TURK,CHINSIM,CHINTRAD,JAPN,KOREAN,CZECH,CAT"
	#
	# Supported languages for localized help files
	#
	#   helplangs="ENUS,FREN,GERM,SPAN,ITAL,SWED"
	#
	set_languages

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

	# Autoresponse file for user installation
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
	cd ${S}/instsetoo/${SOLPATH}/${LANGNO}/normal
	# Setup virtualmake
	export maketype="./setup"
	# We need X to install...
	virtualmake "-v -noexit -r:${T}/autoresponse" || die "virtualmake failed"

	echo
	einfo "Removing build root from registry..."
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
	dosym program/setup ${INSTDIR}/setup

	# Install user autoresponse file
	insinto /etc/openoffice
	sed -e "s|<pv>|${OO_VER}|g" ${T}/rsfile-local > ${T}/autoresponse-${OO_VER}.conf
	doins ${T}/autoresponse-${OO_VER}.conf

	# Install wrapper script
	exeinto /usr/bin
	sed -e "s|<pv>|${OO_VER}|g" \
		${FILESDIR}/${OO_VER}/ooffice-wrapper-1.3 > ${T}/ooffice
	doexe ${T}/ooffice

	# Component symlinks
	for app in calc draw impress html math writer setup; do
		dosym ooffice /usr/bin/oo${app}
	done

	# Install ximian icons
	cd ${PATCHDIR}/desktop/
	insinto /usr/share/pixmaps
	doins *.png

	einfo "Installing Menu shortcuts (need \"gnome\" or \"kde\" in USE)..."
	if [ -n "`use gnome`" ]
	then
		insinto /usr/share/applications
		doins ${FILESDIR}/*.desktop
	fi

	if [ -n "`use kde`" ]
	then
		insinto /usr/share/applnk/Office
		doins ${FILESDIR}/*.desktop
	fi

	# Remove unneeded stuff
	rm -rf ${D}${INSTDIR}/share/cde

	# Make sure these do not get nuked.
	keepdir ${INSTDIR}/user/registry/res/en-us/org/openoffice/{Office,ucb}
	keepdir ${INSTDIR}/user/psprint/{driver,fontmetric}
	keepdir ${INSTDIR}/user/{autocorr,backup,plugin,store,temp,template}
}

pkg_postinst() {

	einfo "******************************************************************"
	einfo " To start OpenOffice.org, run:"
	einfo
	einfo "   $ ooffice"
	einfo
	einfo " Also, for individual components, you can use any of:"
	einfo
	einfo "   oocalc, oodraw, ooimpress, oomath, ooweb or oowriter"
	einfo
	einfo "******************************************************************"
}
