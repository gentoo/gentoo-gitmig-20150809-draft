# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/sun-j2sdk/sun-j2sdk-1.4.0-r3.ebuild,v 1.5 2003/04/23 20:47:57 strider Exp $

# Maintainer: Stefan Jones <cretin@gentoo.org>
# Author: Stefan Jones <cretin@gentoo.org>

# Based on http://tushar.lfsforum.org/javafromscratch.txt (LFS)
# By Tushar Teredesai <Tush@Yahoo.Com>

IUSE=""

inherit java nsplugins

ZLIB_VERSION=1.1.4

JAVA_PATCHES="j2sdk-1.4.0-disable-sanity-check.patch.bz2
              j2sdk-1.4.0-fix-intl-files.patch.bz2
              j2sdk-1.4.0-gcc3-syntax.patch.bz2
              j2sdk-1.4.0-glibc-2.3.1-fixes.patch.bz2
              j2sdk-1.4.0-link-jpda-2-libjvm.patch.bz2
              j2sdk-1.4.0-remove-fixed-paths.patch.bz2"

S=${WORKDIR}/j2sdk

SRC_JAVA="j2sdk-1_4_0-src-scsl.zip"
SRC_MOZHEADERS="j2sdk-1_4_0-mozilla_headers-unix.zip"
SRC_SUNMOTIF="j2sdk-1_4_0-motif-linux-i386.zip"

SRC_URI="http://www.gzip.org/zlib/zlib-${ZLIB_VERSION}.tar.bz2"
		 
DESCRIPTION="Sun's J2SE Development Kit, version 1.4.0"
HOMEPAGE="http://wwws.sun.com/software/java2/download.html"

SLOT="0"
KEYWORDS="x86 -ppc -alpha -sparc "
LICENSE="sun-csl"

RDEPEND="virtual/glibc
	virtual/x11
	>=dev-java/java-config-0.1.3"
DEPEND="${RDEPEND}
	app-arch/zip
	app-arch/unzip
	>=virtual/jdk-1.4
	!x11-libs/lesstif
	!x11-libs/openmotif"

PROVIDE="virtual/jre-1.4.0
	virtual/jdk-1.4.0
	virtual/java-scheme-2"

pkg_setup() {	
	#Check if we have enough space
	if [ `df ${PORTAGE_TMPDIR}/portage/ | tail -n 1 | awk '{ print $4 }'` -le 2097152 ] ; then
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

    if [ ! -f ${DISTDIR}/${SRC_SUNMOTIF} ] ; then
      eerror "Please download ${SRC_SUNMOTIF} from ${HOMEPAGE} to ${DISTDIR}"
      die_flag=1
    fi

	[ ! -z ${die_flag} ] && die "Some source files were not found"
	
	mkdir ${S}
	cd ${S}
	unpack ${SRC_JAVA}

	mkdir mozilla
	cd mozilla
	unpack ${SRC_MOZHEADERS}

	cd ${S}
	for patch in $JAVA_PATCHES ; do
		bzip2 -dc ${FILESDIR}/patches/${patch} | patch -p1 || die "Failed to apply ${patch}"
	done

	# Update zlib to avoid security problem with zlib-1.1.3
	cd ${S}/j2se/src/share/native/java/util/zip
	rm -rf zlib-1.1.3
	unpack zlib-${ZLIB_VERSION}.tar.bz2
	cd zlib-${ZLIB_VERSION}
	mv adler32.c zadler32.c
	mv crc32.c zcrc32.c
	cd ${S}/j2se/make/java/zip/
	cp Makefile Makefile.orig
	chmod +w Makefile
	sed -e "s:1.1.3:${ZLIB_VERSION}:" Makefile.orig > Makefile
	
    mkdir -p ${S}/motif
    cd ${S}/motif
    unpack ${SRC_SUNMOTIF}
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
	#export OTHER_CFLAGS=${CFLAGS}
	#export OTHER_CXXFLAGS=${CXXFLAGS}
	unset CFLAGS CXXFLAGS
	
	export ALT_MOZILLA_PATH="${S}/mozilla"
	export ALT_BOOTDIR=`java-config --jdk-home`
	export ALT_MOTIF_DIR="${S}/motif"
	export ALT_DEVTOOLS_PATH="/usr/bin"
	export MILESTONE="gentoo"
	export BUILD_NUMBER=`date +%s`
	export INSANE=true
	export MAKE_VERBOSE=true
	export OTHER_LDFLAGS="-lpthread"
	export DEV_ONLY=true 

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
	
	inst_plugin /opt/${P}/jre/plugin/i386/ns610/libjavaplugin_oji140.so
	set_java_env ${FILESDIR}/${VMHANDLE}

}

pkg_postinst () {                                                               
	# Set as default VM if none exists
	java_pkg_postinst
}
