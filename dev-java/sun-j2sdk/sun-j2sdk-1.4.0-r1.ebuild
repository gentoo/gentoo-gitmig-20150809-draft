# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Maintainer: Stefan Jones <cretin@gentoo.org>
# Author: Stefan Jones <cretin@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-java/sun-j2sdk/sun-j2sdk-1.4.0-r1.ebuild,v 1.1 2002/11/07 22:53:26 cretin Exp $

# Based on http://tushar.lfsforum.org/javafromscratch.txt (LFS)
# By Tushar Teredesai <Tush@Yahoo.Com>

IUSE=""

inherit java

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

SRC_URI="http://www.gzip.org/zlib/zlib-${ZLIB_VERSION}.tar.bz2"
		 
DESCRIPTION="Sun's J2SE Development Kit, version 1.4.0"
HOMEPAGE="http://java.sun.com/j2se/1.4/download.html"

SLOT="0"
KEYWORDS="x86 -ppc -alpha -sparc -sparc64"
LICENSE="sun-csl"

RDEPEND="virtual/glibc
	virtual/x11
	>=dev-java/java-config-0.1.3"
DEPEND="${RDEPEND}
	app-arch/unzip
	virtual/jdk
	>=x11-libs/lesstif-0.93.36
	!x11-libs/openmotif"

PROVIDE="virtual/jre-1.4.0
	virtual/jdk-1.4.0
	virtual/java-scheme-2"
	
src_unpack() {
	die_flag=""
	if [ ! -f ${DISTDIR}/${SRC_MOZHEADERS} ] ; then
      eerror "Please download ${SRC_MOZHEADERS} from ${HOMEPAGE}"
      die_flag=1
	fi
			
	if [ ! -f ${DISTDIR}/${SRC_JAVA} ] ; then
      eerror "Please download ${SRC_JAVA} from ${HOMEPAGE}"
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
	unset CFLAGS CXXFLAGS
	
	export ALT_MOZILLA_PATH="${S}/mozilla"
	export ALT_BOOTDIR=`java-config --jdk-home`
	export ALT_MOTIF_DIR="/usr"
	export ALT_DEVTOOLS_PATH="/usr/bin"
	export MILESTONE="gentoo"
	export BUILD_NUMBER=`date +%s`
	export INSANE=true
	export MAKE_VERBOSE=true
	export OTHER_LDFLAGS="-lpthread"
	export DEV_ONLY=true 

	cd ${S}/control/make
	make || die

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
	
        if [ "`use mozilla`" ] ; then
		dodir /usr/lib/mozilla/plugins
		dosym /opt/${P}/jre/plugin/i386/ns610/libjavaplugin_oji140.so /usr/lib/mozilla/plugins/
	fi

	set_java_env ${FILESDIR}/${VMHANDLE}

}

pkg_postinst () {                                                               
	# Set as default VM if none exists
	java_pkg_postinst	

	if [ "`use mozilla`" ] ; then                                           
		einfo "The Mozilla browser plugin has been installed as /usr/lib/mozilla/plugins/libjavaplugin_oji140.so"
	else                                                                    
		einfo "To install the Java plugin for Mozilla manually, do:"
		einfo "ln -s /opt/${P}/jre/plugin/i386/ns610/libjavaplugin_oji140.so /usr/lib/mozilla/plugins/"
		einfo "(Make certain the directory /usr/lib/mozilla/plugins exists first)"
	fi
}
