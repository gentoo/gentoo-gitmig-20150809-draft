# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/sun-j2sdk/sun-j2sdk-1.4.1-r1.ebuild,v 1.1 2003/05/24 15:59:41 tberman Exp $

# Maintainer: Stefan Jones <cretin@gentoo.org>
# Author: Stefan Jones <cretin@gentoo.org>

# Based on http://www.linuxfromscratch.org/~tushar/hints/javafromscratch.txt (LFS)
# By Tushar Teredesai <Tush@Yahoo.Com>

IUSE="nptl"

inherit java nsplugins

JAVA_PATCHES="disable-sanity-check
			fix-intl-files
			gcc3-syntax
			glibc-2.3.1-fixes
			link-jpda-2-libjvm
			remove-fixed-paths
			force-motif
			gcc3.3-fixes"

S=${WORKDIR}/j2sdk

SRC_JAVA="j2sdk-1_4_1-src-scsl.zip"
SRC_MOZHEADERS="j2sdk-1_4_1-mozilla_headers-unix.zip"

SRC_URI=""

DESCRIPTION="Sun's J2SE Development Kit, version 1.4.0"
HOMEPAGE="http://wwws.sun.com/software/java2/download.html"

SLOT="0"
KEYWORDS="x86 -ppc -alpha -sparc"
LICENSE="sun-csl"

RDEPEND="virtual/glibc
	virtual/x11
	>=dev-java/java-config-0.1.3"
DEPEND="${RDEPEND}
	sys-apps/cpio
	app-arch/zip
	app-arch/unzip
	>=virtual/jdk-1.4"

PROVIDE="virtual/jre-1.4.1
	virtual/jdk-1.4.1
	virtual/java-scheme-2"

pkg_setup() {	
	#Check if we have enough space
	if [ `df -P ${PORTAGE_TMPDIR}/portage/ | tail -n 1 | awk '{ print $4 }'` -le 2097152 ] ; then
		eerror "You need about 2G of disk space to compile this at ${PORTAGE_TMPDIR}/portage,"
		eerror "it seems you don't have that much, quiting, sorry!"
		die "Not enough disk space"
	fi

	#Check the Current java-version ~ 1.4 and is jdk
	JAVAC=`java-config --javac`
	if [ -z $JAVAC ] ; then
		eerror "Set java-config to use a jdk not a jre" 
		die "The version of java set by java-config doesn't contain javac"
	fi
	
	if [ `java-config --java-version 2>&1 | grep "1\.4\."  | wc -l` -lt 1 ]  ; then
		eerror "JDK is too old, >= 1.4 is required"
		die "The version of jdk pointed to by java-config is not >=1.4"
	fi
}

src_unpack() {
	die_flag=""
	if [ ! -f ${DISTDIR}/${SRC_MOZHEADERS} ] ; then
		eerror "Please download ${SRC_MOZHEADERS} from ${HOMEPAGE} to ${DISTDIR}"
		die_flag=1
	fi
			
	if [ ! -f ${DISTDIR}/${SRC_JAVA} ] ; then
		eerror "Please download ${SRC_JAVA} from ${HOMEPAGE} to ${DISTDIR}"
		die_flag=1
	fi

	[ ! -z ${die_flag} ] && die "Some source files were not found"
	
	mkdir ${S}
	cd ${S}
	unpack ${SRC_JAVA}

	mkdir mozilla
	cd mozilla
	unpack ${SRC_MOZHEADERS}

	use nptl && JAVA_PATCHES="$JAVA_PATCHES pthread"

	cd ${S}
	for patch in $JAVA_PATCHES ; do
		einfo "Applying patch ${patch}"
		cat ${FILESDIR}/${PV}/j2sdk-${PV}-${patch}.patch | patch -p1 || die "Failed to apply ${patch}"
	done
}

src_compile () {
	cd ${S}
	unset CLASSPATH JAVA_HOME JAVAC 

	# Otherwise the command:
	# (cd  /var/tmp/portage/sun-j2sdk-1.4.0-r1/work/j2sdk/control/build/linux-i386/j2re-image; tar cf - .) | \
	#    (cd  /var/tmp/portage/sun-j2sdk-1.4.0-r1/work/j2sdk/control/build/linux-i386/j2sdk-image/jre; tar xf -)
	# Will fail, you have been warned!!!! There are NO sandbox violations anyway
	LD_PRELOAD_SAVE=$LD_PRELOAD
	unset LD_PRELOAD	

	# Any CFLAGS will cause the build to fail! 
	# If you don't believe me ...
	export OTHER_CFLAGS=${CFLAGS}
	export OTHER_CXXFLAGS=${CXXFLAGS}
	unset CFLAGS CXXFLAGS LDFLAGS
	
	export ALT_MOZILLA_PATH="${S}/mozilla"
	export ALT_BOOTDIR=`java-config --jdk-home`
	export ALT_CACERTS_FILE=${ALT_BOOTDIR}/jre/lib/security/cacerts
	export ALT_MOTIF_DIR="${S}/motif"
	export ALT_DEVTOOLS_PATH="/usr/bin"
	export MILESTONE="gentoo"
	export BUILD_NUMBER=`date +%s`
	export LIBS="-lstdc++"
	export OTHER_LDFLAGS="-lpthread"
	export INSANE=true
	export MAKE_VERBOSE=true
	export DEV_ONLY=true 
	export USRBIN_PATH=""

	cd ${S}/control/make
	# MUST use make, we DONT want any -j options!
	JOBS=`echo "${MAKEOPTS}" | sed -e "s/.*-j\([0-9]\+\).*/\1/"`
	if [ -z "$JOBS" ]; then
		JOBS=1
	fi
	make HOTSPOT_BUILD_JOBS=${JOBS} || die

	export LD_PRELOAD=$LD_PRELOAD_SAVE
}

src_install () {
	
	dodir /opt/${P}

	cd ${S}/control/build/linux-*/j2sdk-image
	local dirs="bin include jre lib"
	dodir /opt/${P}
	
	for i in $dirs ; do
		cp -a $i ${D}/opt/${P}/
	done
	
	dodoc COPYRIGHT README LICENSE
	dohtml README.html
	
	doman man/man1/*.1
	
	dodir /opt/${P}/share/
	cp -a demo src.zip ${D}/opt/${P}/share/

	chown -R root.root ${D}/opt/${P}

	inst_plugin /opt/${P}/jre/plugin/i386/ns610/libjavaplugin_oji.so
	set_java_env ${FILESDIR}/${VMHANDLE}
}

pkg_postinst () {                                                               
	# Set as default VM if none exists
	java_pkg_postinst
}
