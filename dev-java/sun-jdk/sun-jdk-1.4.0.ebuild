# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Tools Team <tools@gentoo.org>
# Author: Daniel Mettler <mettlerd@icu.unizh.ch>
# /space/gentoo/cvsroot/gentoo-x86/dev-java/sun-jdk/sun-jdk-1.4_pre1.ebuild,v 1.1 2002/02/10 22:30:10 karltk Exp

At="j2sdk-1_4_0-linux-i386.bin"
S=${WORKDIR}/j2sdk1.4.0
SRC_URI=""
DESCRIPTION="Sun's J2SE Development Kit, version 1.4.0"
HOMEPAGE="http://java.sun.com/j2se/1.4/download.html"

DEPEND="virtual/glibc
	>=dev-java/java-config-0.1.3"
RDEPEND="$DEPEND"

PROVIDE="virtual/jre-1.4
	virtual/jdk-1.4"
	
src_unpack() {
	if [ ! -f ${DISTDIR}/${At} ] ; then
		die "Please download ${At} from ${HOMEPAGE} (select the \"Linux GNUZIP Tar shell script\" package format of the SDK) and move it to ${DISTDIR}"
	fi
	tail +295 ${DISTDIR}/${At} > install.sfx
	chmod +x install.sfx
	./install.sfx || die
	rm install.sfx
}

src_install () {
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
	
	dodir /etc/env.d
	echo "PATH=/opt/${P}/bin" > ${D}/etc/env.d/21jdk
	echo "ROOTPATH=/opt/${P}/bin" >> ${D}/etc/env.d/21jdk
        echo "JDK_HOME=/opt/${P}" >> ${D}/etc/env.d/21jdk
        echo "JAVA_HOME=/opt/${P}" >> ${D}/etc/env.d/21jdk
	echo "CLASSPATH=/opt/${P}/jre/lib/rt.jar" >> ${D}/etc/env.d/21jdk
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
