# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/openoffice/openoffice-1.1.3.ebuild,v 1.8 2004/11/15 15:20:26 suka Exp $

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


IUSE="gnome kde java curl"

LOC="/opt"
INSTDIR="${LOC}/OpenOffice.org"
S="${WORKDIR}/OOo_${PV}_src"
DESCRIPTION="OpenOffice.org, a full office productivity suite."
SRC_URI="mirror://openoffice/stable/${PV}/OOo_${PV}-1_source.tar.gz"
HOMEPAGE="http://www.openoffice.org/"

LICENSE="|| ( LGPL-2  SISSL-1.1 )"
SLOT="0"
KEYWORDS="x86 ~sparc"

RDEPEND="!app-office/openoffice-bin
	>=sys-libs/glibc-2.1
	!=sys-libs/glibc-2.3.1*
	>=dev-lang/perl-5.0
	>=media-libs/libart_lgpl-2.3.13
	>=x11-libs/startup-notification-0.5
	>=media-libs/freetype-2.1.4
	virtual/x11
	app-arch/zip
	app-arch/unzip
	dev-libs/expat
	java? ( >=virtual/jre-1.4.1 )
	virtual/lpr
	ppc? ( >=sys-libs/glibc-2.2.5-r7
	>=sys-devel/gcc-3.2.1 )"

DEPEND="${RDEPEND}
	>=sys-apps/findutils-4.1.20-r1
	app-shells/tcsh
	dev-util/pkgconfig
	curl? ( net-misc/curl )
	sys-libs/pam
	sys-libs/zlib
	!dev-util/dmake
	java? ( >=virtual/jdk-1.4.1 )
	!java? ( dev-libs/libxslt )"

pkg_setup() {

	if [ "$(gcc-version)" != "3.2" ] && [ "$(gcc-version)" != "3.3" ]
	then
		eerror
		eerror "This build needs gcc-3.{2,3}.x, but due to profile"
		eerror "settings, it cannot DEPEND on it, so please merge it"
		eerror "manually:"
		eerror
		eerror " #  ebuild ${PORTDIR}/sys-devel/gcc/gcc-3.2.1.ebuild merge"
		eerror
		eerror "Please make sure that you use the latest availible revision of"
		eerror "gcc."
		eerror
		die
	fi

	if use java
	then
		if [ -z "$(/usr/bin/java-config -O | grep "blackdown-jdk")" ] && [ "${FORCE_JAVA}" != "yes" ]
		then
			eerror
			eerror "This ebuild has only been tested with the blackdown port of"
			eerror "java.  If you use another java implementation, it could fail"
			eerror "horribly, so please merge the blackdown-jdk and set it as"
			eerror "system VM before proceeding:"
			eerror
			eerror " # emerge blackdown-jdk"
			eerror " # java-config --set-system-vm=blackdown-jdk-<VERSION>"
			eerror " # env-update"
			eerror " # source /etc/profile"
			eerror
			eerror "Please adjust <VERSION> according to the version installed in"
			eerror "/opt."
			eerror
			eerror "If you however want to test another JDK (not officially supported),"
			eerror "you could do the following:"
			eerror
			eerror " # export FORCE_JAVA=yes"
			eerror
			die
		fi
	fi

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
			export NEW_GCC="1"
			export GCC_PROFILE="$(/usr/sbin/gcc-config --get-current-profile)"

			# Just recheck gcc version ...
			if [ "$(gcc-version)" != "3.2" ] && [ "$(gcc-version)" != "3.3" ]
			then
				# See if we can get a gcc profile we know is proper ...
				if /usr/sbin/gcc-config --get-bin-path ${CHOST}-3.2.1 &> /dev/null
				then
					export PATH="$(/usr/sbin/gcc-config --get-bin-path ${CHOST}-3.2.1):${PATH}"
					export GCC_PROFILE="${CHOST}-3.2.1"
				else
					eerror "This build needs gcc-3.2 or gcc-3.3!"
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

	#Still needed: The STLport patch
	cd ${S}
	rm stlport/STLport-4.5.3.patch || die
	epatch ${FILESDIR}/${PV}/newstlportfix.patch

	epatch ${FILESDIR}/${PV}/openoffice-java.patch

	epatch ${FILESDIR}/${PV}/gcc-instlib.patch

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
	export CXXFLAGS="${CXXFLAGS} -fno-for-scope -fpermissive -fno-rtti"
	perl -pi -e "s|^CFLAGSOPT=.*|CFLAGSOPT=${CFLAGS}|g" \
		${S}/solenv/inc/unxlngi4.mk
	perl -pi -e "s|^CFLAGSCXX=.*|CFLAGSCXX=${CXXFLAGS}|g" \
		${S}/solenv/inc/unxlngi4.mk

	#Do our own branding by setting gentoo linux as the vendor
	sed -i -e "s,\(//\)\(.*\)\(my company\),\2Gentoo Linux," ${S}/offmgr/source/offapp/intro/ooo.src
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
	export MYCONF=""

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

	# Do NOT compile with a external STLport, as gcc-2.95.3 users will
	# get linker errors due to the ABI being different (STLport will be
	# compiled with 2.95.3, while OO is compiled with 3.x). (Az)
	einfo "Configuring OpenOffice.org with language support for ${LFULLNAME}..."
	cd ${S}/config_office
	rm -f config.cache

	if [ "LANGNAME" != "ENUS" ]; then
		LANGNAME="${LANGNAME},ENUS"
	fi

	use sparc && MYCONF="${MYCONF} --disable-mozilla"

	MYCONF="${MYCONF} --enable-libart \
		--with-lang=${LANGNAME} \
		--enable-libsn \
		--without-fonts \
		--with-system-zlib \
		--with-system-freetype"

	./configure ${MYCONF} || die

	cd ${S}
	get_EnvSet

	# Set $ECPUS to amount of processes multiprocessing build should use.
	# NOTE:  Setting this too high might cause dmake to segfault!!
	#        Setting this to anything but "1" on my pentium4 causes things
	#        to segfault :(
	[ -z "${ECPUS}" ] && export ECPUS="1"

	# Should the build use multiprocessing?
	# We use build.pl directly, as dmake tends to segfault. (Az)
	if [ "${ECPUS}" -gt 1 ]
	then
		buildcmd="${S}/solenv/bin/build.pl --all -P${ECPUS} product=full strip=true --dlv_switch link"
	else
		buildcmd="${S}/solenv/bin/build.pl --all product=full strip=true --dlv_switch link"
	fi

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
	echo "source ${S}/${LinuxEnvSet} && cd ${S}/instsetoo && ${buildcmd}" > build.sh
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
		DESTINATIONPATH=<home>/.openoffice/<pv>

		[JAVA]
		JavaSupport=none
	END_RS

	# Fixing install location in response file
	sed -e "s|<destdir>|${D}${INSTDIR}|" \
		${T}/rsfile-global > ${T}/autoresponse || die

	einfo "Installing OpenOffice.org into build root..."
	dodir ${INSTDIR}
	cd ${S}/instsetoo/${SOLPATH}/${LANGNO}/normal
	./setup -v -noexit -nogui -r:${T}/autoresponse || die "Setup failed"

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
	for x in "soffice program/spadmin" \
		"program/setup setup" \
		"program/spadmin spadmin"
	do
		dosym $(echo ${x} | awk '{print $1}') \
			${INSTDIR}/$(echo ${x} | awk '{print $2}')
	done

	# Install user autoresponse file
	insinto /etc/openoffice
	sed -e "s|<pv>|${PV}|g" ${T}/rsfile-local > ${T}/autoresponse-${PV}.conf
	doins ${T}/autoresponse-${PV}.conf

	# Install wrapper script
	exeinto /usr/bin
	sed -e "s|<pv>|${PV}|g" \
		${FILESDIR}/${PV}/ooffice-wrapper-1.3 > ${T}/ooffice
	doexe ${T}/ooffice

	# Component symlinks
	for app in calc draw impress math writer web setup padmin; do
		dosym ooffice /usr/bin/oo${app}
	done

	einfo "Installing Menu shortcuts (need \"gnome\" or \"kde\" in USE)..."
	if use gnome
	then
		insinto /usr/share/gnome/apps/OpenOffice.org
		# Install the files needed for the catagory
		doins ${D}${INSTDIR}/share/gnome/net/.directory
		doins ${D}${INSTDIR}/share/gnome/net/.order

		# Change this to ooo*.desktop from *.desktop for now, since
		# otherwise two sets of icons will appear in the GNOME menu.
		# <brad@gentoo.org> (04 Aug 2003)
		for x in ${D}${INSTDIR}/share/gnome/net/ooo*.desktop
		do
			# We have to handle soffice and setup differently
			perl -pi -e "s:${INSTDIR}/program/setup:/usr/bin/oosetup:g" ${x}
			perl -pi -e "s:${INSTDIR}/program/soffice:/usr/bin/ooffice:g" ${x}
			# Now fix the rest
			perl -pi -e "s:${INSTDIR}/program/s:/usr/bin/oo:g" ${x}
			doins ${x}
		done
	fi

	if use kde
	then
		local kdeloc="${D}${INSTDIR}/share/kde/net/"

		insinto /usr/share/applnk/OpenOffice.org\ 1.1
		# Install the files needed for the catagory
		doins ${kdeloc}/.directory
		dodir /usr/share
		# Install the icons and mime info
		cp -a ${D}${INSTDIR}/share/kde/net/share/mimelnk ${D}${INSTDIR}/share/kde/net/share/icons ${D}/usr/share

		for x in ${kdeloc}/*.desktop
		do
			# We have to handle soffice and setup differently
			perl -pi -e "s:${INSTDIR}/program/setup:/usr/bin/oosetup:g" ${x}
			perl -pi -e "s:${INSTDIR}/program/soffice:/usr/bin/ooffice:g" ${x}
			# Now fix the rest
			perl -pi -e "s:${INSTDIR}/program/s:/usr/bin/oo:g" ${x}
			doins ${x}
		done
	fi

	# Do not actually install the desktop bindings for users, we have
	# installed them globally
	for module in gid_Module_Optional_Gnome gid_Module_Optional_Kde gid_Module_Optional_Cde
	do
		perl -pi -e "/^Module $module/ .. /^End/ and s|(Installed.*)=.*|\1= NO;|" \
		${D}${INSTDIR}/program/instdb.ins
	done



	# Remove unneeded stuff
	rm -rf ${D}${INSTDIR}/share/cde

	# Make sure these do not get nuked.
	keepdir ${INSTDIR}/user/registry/res/en-us/org/openoffice/{Office,ucb} ${INSTDIR}/user/psprint/{driver,fontmetric} ${INSTDIR}/user/{autocorr,backup,plugin,store,temp,template}
}

pkg_postinst() {

	einfo " To start OpenOffice.org, run:"
	einfo
	einfo "   $ ooffice"
	einfo
	einfo " Also, for individual components, you can use any of:"
	einfo
	einfo "   oocalc, oodraw, ooimpress, oomath, ooweb or oowriter"
}

