# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/openoffice-ximian/openoffice-ximian-1.3.6.ebuild,v 1.9 2005/03/28 08:37:55 suka Exp $

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

inherit flag-o-matic eutils toolchain-funcs

IUSE="gnome kde java curl zlib nptl"

OO_VER=1.1.3
PATCHLEVEL=OOO_1_1_3
ICON_VER=OOO_1_1-10
KDE_ICON_VER=OOO_1_1-0.3
KDE_ICON_PATH=documents/159/1975
INSTDIR="/opt/Ximian-OpenOffice"
PATCHDIR=${WORKDIR}/ooo-build-${PV}
S="${WORKDIR}/OOo_${OO_VER}_src"
DESCRIPTION="Ximian-ized version of OpenOffice.org, a full office productivity suite."
SRC_URI="mirror://openoffice/stable/${OO_VER}/OOo_${OO_VER}-1_source.tar.gz
	http://www.stlport.org/archive/STLport-4.6.2.tar.gz
	http://ooo.ximian.com/packages/${PATCHLEVEL}/ooo-build-${PV}.tar.gz
	http://ooo.ximian.com/packages/libwpd-snap-20040823.tar.gz
	mirror://gentoo/OOo-gentoo-splash-1.1.tar.bz2
	gnome? ( http://ooo.ximian.com/packages/ooo-icons-${ICON_VER}.tar.gz )
	!kde? ( http://ooo.ximian.com/packages/ooo-icons-${ICON_VER}.tar.gz )
	kde? ( http://kde.openoffice.org/files/${KDE_ICON_PATH}/ooo-KDE_icons-${KDE_ICON_VER}.tar.gz )"

HOMEPAGE="http://ooo.ximian.com"

LICENSE="|| ( LGPL-2  SISSL-1.1 )"
SLOT="0"
KEYWORDS="~x86 ppc"

RDEPEND="!app-office/openoffice-ximian-bin
	virtual/x11
	virtual/libc
	virtual/lpr
	!=sys-libs/glibc-2.3.1*
	>=dev-lang/perl-5.0
	gnome? ( >=x11-libs/gtk+-2.0
		>=gnome-base/gnome-vfs-2.0
		>=dev-libs/libxml2-2.0 )
	kde? ( kde-base/kdelibs )
	>=media-libs/libart_lgpl-2.3.13
	>=x11-libs/startup-notification-0.5
	>=media-libs/freetype-2.1.4
	media-libs/fontconfig
	media-gfx/imagemagick
	media-libs/libpng
	sys-devel/flex
	sys-devel/bison
	app-arch/zip
	app-arch/unzip
	dev-libs/expat
	java? ( >=virtual/jdk-1.4.1 )
	ppc? ( >=sys-libs/glibc-2.2.5-r7
	>=sys-devel/gcc-3.2.1 )"

DEPEND="${RDEPEND}
	>=sys-apps/findutils-4.1.20-r1
	app-shells/tcsh
	dev-util/pkgconfig
	dev-util/intltool
	curl? ( net-misc/curl )
	zlib? ( sys-libs/zlib )
	sys-libs/pam
	!dev-util/dmake
	!java? ( dev-libs/libxslt )"

PROVIDE="virtual/ooo"

pkg_setup() {

	if use java
	then
		if [ -z "${JDK_HOME}" ] || [ ! -d "${JDK_HOME}" ]
		then
			eerror "In order to compile java sources you have to set the"
			eerror "\$JDK_HOME environment properly."
			eerror ""
			eerror "You can achieve this by using the java-config tool:"
			eerror "  emerge java-config"
			die "Couldn't find a valid JDK home"
		fi
	fi

	ewarn " This version should now also compile fine with gcc 3.4.x "
	ewarn " If you encounter problems in relation to this, please report "
	ewarn " them to http://bugs.gentoo.org "
	ewarn ""
	ewarn " It is important to note that OpenOffice.org is a very fragile  "
	ewarn " build when it comes to CFLAGS.  A number of flags have already "
	ewarn " been filtered out.  If you experience difficulty merging this  "
	ewarn " package and use agressive CFLAGS, lower the CFLAGS and try to  "
	ewarn " merge again.					               "

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
	unset LC_ALL

	if [ -x /usr/sbin/gcc-config ]
	then
		# Do we have a gcc that use the new layout and gcc-config ?
		if /usr/sbin/gcc-config --get-current-profile &> /dev/null
		then
			export GCC_PROFILE="$(/usr/sbin/gcc-config --get-current-profile)"

			# Just recheck gcc version ...
			if [ "$(gcc-version)" != "3.2" ] && [ "$(gcc-version)" != "3.3" ] && [ "$(gcc-version)" != "3.4" ]
			then
				# See if we can get a gcc profile we know is proper ...
				if /usr/sbin/gcc-config --get-bin-path ${CHOST}-3.2.1 &> /dev/null
				then
					export PATH="$(/usr/sbin/gcc-config --get-bin-path ${CHOST}-3.2.1):${PATH}"
					export GCC_PROFILE="${CHOST}-3.2.1"
				else
					eerror "This build needs gcc-3.2, gcc-3.3 or gcc-3.4!"
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
	unpack ${A}

	#Beginnings of our own patchset
	cd ${PATCHDIR}
	epatch ${FILESDIR}/${OO_VER}/gentoo-${PV}.patch

	#Still needed: The STLport patch
	cd ${S}
	cp ${DISTDIR}/STLport-4.6.2.tar.gz ${S}/stlport/download || die
	epatch ${FILESDIR}/${OO_VER}/newstlportfix.patch

	# fix for bug #82385
	epatch ${FILESDIR}/${OO_VER}/getcompver.awk.patch

	if use ppc; then
		epatch ${FILESDIR}/${OO_VER}/STLport-vector.patch
	fi

	#Add our own splash screen
	epatch ${FILESDIR}/${OO_VER}/gentoo-splash.diff

	#Detect which look and patchset we are using
	export DISTRO="Gentoo"
	export MYCONF=""
	export ICONDIR=${WORKDIR}/ooo-icons-${ICON_VER}

	if use gnome; then
		export DISTRO="GentooGNOME"
		export MYCONF="--enable-gtk"
	fi

	if use kde; then
		export MYCONF="${MYCONF} --enable-kde"
		if use !gnome; then
			export DISTRO="GentooKDE"
			export MYCONF="--enable-kde"
			export ICONDIR=${WORKDIR}/ooo-KDE_icons-${KDE_ICON_VER}
		fi
	fi

	#Finally apply the patches
	einfo "Applying Ximian OO.org Patches"
	${PATCHDIR}/patches/apply.pl ${PATCHDIR}/patches/${PATCHLEVEL} ${S} -f --distro=${DISTRO} || die "Ximian patches failed"

	# GCC 3.4.x fixes
	if [ "$(gcc-version)" = "3.4" ]
	then
		epatch ${FILESDIR}/${OO_VER}/gcc34.patch.bz2
		use !java && epatch ${FILESDIR}/${OO_VER}/gcc34-nojava-fix.patch
		use nptl && epatch ${FILESDIR}/${OO_VER}/gcc34-nptl-fix.patch
		use gnome && epatch ${FILESDIR}/${OO_VER}/gcc34-gnome.patch
	fi

	einfo "Installing / Scaling Icons"
	${PATCHDIR}/bin/scale-icons ${S} || die
	cp -af ${ICONDIR}/* ${S} || die

	einfo "Copying splash screens in place"
	cp -af ${WORKDIR}/gentoo-splash/open*.bmp ${S}/offmgr/res/ || die

	einfo "Copying libpwd tarball in build dir"
	mkdir -p ${S}/libwpd/download/ || die
	cp -af ${DISTDIR}/libwpd-snap-20040823.tar.gz ${S}/libwpd/download/ || die

	einfo "Munging font mappings ..."
	${PATCHDIR}/bin/font-munge ${S}/officecfg/registry/data/org/openoffice/VCL.xcu || die
	echo "done munging fonts."
}

get_EnvSet() {

	# Determine what Env file we should be using (Az)
	export LinuxEnvSet="LinuxIntelEnv.Set.sh"
	use sparc && export LinuxEnvSet="LinuxSparcEnv.Set.sh"
	use ppc && export LinuxEnvSet="LinuxPPCEnv.Set.sh"
	use alpha && export LinuxEnvSet="LinuxAlphaEnv.Set.sh"

	# Get build specific stuff (Az)
	export SOLVER="$(awk '/^UPD=/ {gsub(/\"/, ""); gsub(/UPD=/, ""); print $0}' ${LinuxEnvSet})"
	export SOLPATH="$(awk '/^INPATH=/ {gsub(/\"/, ""); gsub(/INPATH=/, ""); print $0}' ${LinuxEnvSet})"
}

src_compile() {

	addpredict /bin
	addpredict /root/.gconfd
	local buildcmd=""

	# dmake security patch
	cd ${S}/dmake
	autoconf || die

	#Check if we use java
	if use java
	then
		MYCONF="${MYCONF} --with-jdk-home=${JAVA_HOME}"
	else
		MYCONF="${MYCONF} --disable-java"
	fi

	#See if we use system-curl
	if use curl
	then
		MYCONF="${MYCONF} --with-system-curl"
	fi

	#See if we use system-zlib
	if use zlib
	then
		MYCONF="${MYCONF} --with-system-zlib"
	fi

	# Do NOT compile with a external STLport, as gcc-2.95.3 users will
	# get linker errors due to the ABI being different (STLport will be
	# compiled with 2.95.3, while OO is compiled with 3.x). (Az)
	einfo "Configuring OpenOffice.org with language support for ${LFULLNAME}..."
	cd ${S}/config_office
	rm -f config.cache || die
	autoconf || die
	MYCONF="${MYCONF} --enable-libart \
		--enable-libsn \
		--enable-crashdump=no \
		--with-lang=ENUS,${LANGNAME} \
		--without-fonts \
		--disable-rpath \
		--enable-fontconfig \
		--with-system-freetype \
		--with-system-xrender \
		--disable-mozilla"

	./configure ${MYCONF} || die

	cd ${S}
	get_EnvSet

	# Build as minimal as possible
	export BUILD_MINIMAL="${LANGNO}"

	#Get info for parallel build
	export JOBS=`echo "${MAKEOPTS}" | sed -e "s/.*-j\([0-9]\+\).*/\1/"`

	if [ "${JOBS}" -gt 10 ]
	then
		export JOBS="10"
		einfo "dmake fails with too much parallel jobs, so limiting to 10"
	fi

	export buildcmd="${S}/solenv/bin/build.pl --all product=full strip=true --dlv_switch link"

	# Should the build use multiprocessing? Not enabled by default, as it tends to break 
	if [ "${WANT_DISTCC}" == "true" ]
	then
		if [ "${JOBS}" -gt 1 ]
		then
			export buildcmd="${buildcmd} -P${JOBS}"
			einfo "Using distcc, Good Luck"
		fi
	fi

	# Compile problems with these ...
	filter-flags "-funroll-loops"
	filter-flags "-fomit-frame-pointer"
	filter-flags "-fprefetch-loop-arrays"
	filter-flags "-fno-default-inline"
	filter-flags "-fstack-protector"
	filter-flags "-ftracer"
	append-flags "-fno-strict-aliasing"
	replace-flags "-O3" "-O2"
	replace-flags "-Os" "-O2"

	if [ "$(gcc-version)" == "3.2" ]; then
		einfo "You use a buggy gcc, so replacing -march=pentium4 with -march=pentium3"
		replace-flags "-march=pentium4" "-march=pentium3 -mcpu=pentium4"
	fi

	# Now for our optimization flags ...	
	export ARCH_FLAGS="${CFLAGS}"

	if [ -z "$(grep 'CCCOMP' ${S}/${LinuxEnvSet})" ]
	then
		# Set CCCOMP and CXXCOMP.  This is still needed for STLport
		export CCCOMP="$(tc-getCC)"
		export CXXCOMP="$(tc-getCXX)"
	fi

	einfo "Bootstrapping OpenOffice.org..."
	# Get things ready for bootstrap (Az)
	chmod 0755 ${S}/solenv/bin/*.pl
	# Bootstrap ...
	./bootstrap || die

	einfo "Building OpenOffice.org..."
	echo "source ${S}/${LinuxEnvSet} && cd ${S}/instsetoo && LINK=g++ ${buildcmd}" > build.sh
	sh build.sh || die "Build failed!"

	[ -d ${S}/instsetoo/${SOLPATH} ] || die "Cannot find build directory!"
}

src_install() {

	# Sandbox issues; bug #11838
	addpredict "/user"
	addpredict "/share"
	addpredict "/dev/dri"
	addpredict "/usr/bin/soffice"
	addpredict "/pspfontcache"
	addpredict "/opt/OpenOffice.org/foo.tmp"
	addpredict "/opt/OpenOffice.org/delme"

	# The install part should now be relatively OK compared to
	# what it was.  Basically we use autoresponse files to install
	# unattended.  Afterwards we
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
		DESTINATIONPATH=<home>/.xopenoffice/<pv>

		[JAVA]
		JavaSupport=none
	END_RS

	# Fixing install location in response file
	sed -e "s|<destdir>|${D}${INSTDIR}|" \
		${T}/rsfile-global > ${T}/autoresponse || die

	einfo "Installing Ximian-OpenOffice.org into build root..."
	dodir ${INSTDIR}
	cd ${S}/instsetoo/${SOLPATH}/${LANGNO}/normal
	./setup -v -noexit -nogui -r:${T}/autoresponse || die "Setup failed"

	#Fix for parallel install
	sed -i -e s/sversionrc/xversionrc/g ${D}${INSTDIR}/program/bootstraprc ${D}${INSTDIR}/program/instdb.ins || die

	echo
	einfo "Removing build root from registry..."
	# Remove totally useless stuff.
	rm -f ${D}${INSTDIR}/program/{setup.log,sopatchlevel.sh} || die
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
	insinto /etc/ximian-openoffice
	sed -e "s|<pv>|${OO_VER}|g" ${T}/rsfile-local > ${T}/autoresponse-${OO_VER}.conf
	doins ${T}/autoresponse-${OO_VER}.conf

	# Install wrapper script
	exeinto /usr/bin
	sed -e "s|<pv>|${OO_VER}|g" \
		${FILESDIR}/${OO_VER}/xooffice-wrapper-1.3 > ${T}/xooffice
	doexe ${T}/xooffice

	# Component symlinks
	for app in calc draw impress html math writer setup; do
		dosym xooffice /usr/bin/xoo${app}
	done

	# Install icons and menu shortcuts
	cd ${PATCHDIR}/desktop/
	insinto /usr/share/pixmaps
	doins *.png

	einfo "Installing menu shortcuts"
	for menu in drawing presentation spreadsheet textdoc; do
		intltool-merge -d ../po ${menu}.desktop.in xoo-${menu}.desktop;
	done
	sed -i -e s/'=oo'/'=xoo'/g *.desktop
	insinto /usr/share/applications
	doins *.desktop

	einfo "Installing mime info (need \"gnome\" or \"kde\" in USE)..."
	if use gnome
	then
		insinto /usr/share/application-registry
		doins ${FILESDIR}/${OO_VER}/ximian-openoffice.applications
		insinto /usr/share/mime-info
		doins ${FILESDIR}/${OO_VER}/ximian-openoffice.keys
	fi

	if use kde
	then
		insinto /usr/share/mimelnk/application
		doins ${S}/sysui/${SOLPATH}/misc/kde/share/mimelnk/application/*
	fi

	# Install corrected Symbol Font
	insinto /usr/share/fonts/TTF/
	doins ${PATCHDIR}/fonts/*.ttf

	# Remove unneeded stuff
	rm -rf ${D}${INSTDIR}/share/cde || die

	# Fix instdb.ins, to *not* install local copies of these
	for entry in Kdeapplnk Kdemimetext Kdeicons Gnome_Apps Gnome_Icons Gnome2_Apps; do
		perl -pi -e "/^File gid_File_Extra_$entry/ .. /^End/ and (\
			s|^\tSize\s+\= .*|\tSize\t\t = 0;\r| or \
			s|^\tArchiveFiles\s+\= .*|\tArchiveFiles\t = 0;\r| or \
			s|^\tArchiveSize\s+\= .*|\tArchiveSize\t = 0;\r| or \
			s|^\tContains\s+\= .*|\tContains\t = ();\r| or \
			s|\t\t\t\t\t\".*|\r|g)" \
			${D}${INSTDIR}/program/instdb.ins
	done

	# Make sure these do not get nuked.
	keepdir ${INSTDIR}/user/registry/res/en-us/org/openoffice/{Office,ucb} ${INSTDIR}/user/psprint/{driver,fontmetric} ${INSTDIR}/user/{autocorr,backup,plugin,store,temp,template}
}

pkg_postinst() {

	einfo " To start Ximian-OpenOffice.org, run:"
	einfo
	einfo "   $ xooffice"
	einfo
	einfo " Also, for individual components, you can use any of:"
	einfo
	einfo "   xoocalc, xoodraw, xooimpress, xoomath, xooweb or xoowriter"
}
