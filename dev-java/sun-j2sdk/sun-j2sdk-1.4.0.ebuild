# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Tools Team <tools@gentoo.org>
# Author: Daniel Mettler <mettlerd@icu.unizh.ch>
# $Header: /var/cvsroot/gentoo-x86/dev-java/sun-j2sdk/sun-j2sdk-1.4.0.ebuild,v 1.3 2002/09/08 00:29:32 karltk Exp $

P=sun-jdk-1.4.0
S=${WORKDIR}/j2sdk
SRC_URI="http://java.sun.com/j2sdk-1_4_0-src-scsl.zip
	http://java.sun.com/j2sdk-sec-1_4_0-src-scsl.zip
	http://java.sun.com/j2sdk-1_4_0-motif-linux-i386.zip
	http://java.sun.com/j2sdk-1_4_0-mozilla_headers-unix.zip"
DESCRIPTION="Sun's J2SE Development Kit, version 1.4.0"
HOMEPAGE="http://java.sun.com/j2se/1.4/download.html"

SLOT="0"
KEYWORDS="x86 -ppc"
LICENSE="sun-csl"

RDEPEND="virtual/glibc
	virtual/x11
	>=dev-java/java-config-0.1.3"
DEPEND="$RDEPEND
	app-arch/unzip
	~dev-java/sun-jdk-1.4.0"

PROVIDE="virtual/jre-1.4
	virtual/jdk-1.4
	virtual/java-scheme-2"
	
src_unpack() {
	mkdir ${S}
	cd ${S}
	unzip -o ${DISTDIR}/j2sdk-1_4_0-src-scsl.zip
	unzip -o ${DISTDIR}/j2sdk-sec-1_4_0-src-scsl.zip
	mkdir mozilla
	cd mozilla
	unzip -o ${DISTDIR}/j2sdk-1_4_0-mozilla_headers-unix.zip
	cd ..
	mkdir motif
	cd motif
	unzip -o ${DISTDIR}/j2sdk-1_4_0-motif-linux-i386.zip
	cd ../..
	chmod u+w `grep "\--- j2sdk/" ${FILESDIR}/j2sdk-1.4.0-gcc3.patch | awk '{print $2}'`
	cd ${S}
	patch -p1 <${FILESDIR}/j2sdk-1.4.0-gcc3.patch || die "Failed to apply GCC patch"
	cd j2se/make/common
	mv Defs-linux.gmk Defs-linux.gmk_orig
	sed -e "s#^\(CFLAGS_OPT.*\)#\1 ${CFLAGS}#g" \
	    -e "s#^\(CXXFLAGS_OPT.*\)#\1 ${CXXFLAGS}#g" \
	    Defs-linux.gmk_orig > Defs-linux.gmk
	cd ../../../..
	chmod u-w `grep "\--- j2sdk/" ${FILESDIR}/j2sdk-1.4.0-gcc3.patch | awk '{print $2}'`
	cd ${S}
}

src_compile () {
	unset CLASSPATH JAVA_HOME JAVAC
	export ALT_MOZILLA_PATH="${S}/mozilla"
	export ALT_BOOTDIR="/opt/${P}"
	export ALT_MOTIF_DIR="${S}/motif"
	cd control/make

	# MUST use make, we DONT want any -j options!
	JOBS=`echo "${MAKEOPTS}" | sed -e "s/.*-j\([0-9]\+\).*/\1/"`
	if [ -z "$JOBS" ]; then
	    JOBS=1
	fi
	make all DEV_ONLY=true HOTSPOT_BUILD_JOBS=${JOBS} || die
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
	
        dodir /etc/env.d/java 
	sed \
		-e "s/@P@/${P}/g" \
		-e "s/@PV@/${PV}/g" \
		-e "s/@PF@/${PF}/g" \
		< ${FILESDIR}/sun-jdk-${PV} \
                > ${D}/etc/env.d/java/20sun-jdk-${PV} 
}

pkg_postinst () {                                                               
	if [ "`use mozilla`" ] ; then                                           
		einfo "The Mozilla browser plugin has been installed as /usr/lib/mozilla/plugins/libjavaplugin_oji140.so"
	else                                                                    
		einfo "To install the Java plugin for Mozilla manually, do:"
		einfo "ln -s /opt/${P}/jre/plugin/i386/ns610/libjavaplugin_oji140.so /usr/lib/mozilla/plugins/"
		einfo "(Make certain the directory /usr/lib/mozilla/plugins exists first)"
	fi
}
