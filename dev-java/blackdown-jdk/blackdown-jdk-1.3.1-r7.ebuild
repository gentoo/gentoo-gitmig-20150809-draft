# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-java/blackdown-jdk/blackdown-jdk-1.3.1-r7.ebuild,v 1.6 2002/08/26 16:48:25 karltk Exp $

. /usr/portage/eclass/inherit.eclass
inherit java

case `system_arch` in
	ppc)
		PLATFORM="ppc"
		FCS="FCS-02b"
		MY_P="j2sdk-1.3.1-02b-FCS-linux-ppc.bin"
		;;

	i386)
		PLATFORM="i386"
		FCS="FCS"
		MY_P="j2sdk-1.3.1-FCS-linux-i386.tar.bz2"
		;;
	sparc)
		;;

	sparc64)
		;;
esac

S=${WORKDIR}/j2sdk1.3.1
DESCRIPTION="Blackdown Java Development Kit 1.3.1"
SRC_URI="ftp://metalab.unc.edu/pub/linux/devel/lang/java/blackdown.org/JDK-1.3.1/${PLATFORM}/${FCS}/${MY_P}"
HOMEPAGE="http://www.blackdown.org"
DEPEND="virtual/glibc
	>=dev-java/java-config-0.2.0
	doc? ( =dev-java/java-sdk-docs-1.3.1* )"
RDEPEND="$DEPEND"
PROVIDE="virtual/jdk-1.3.1
	virtual/jre-1.3.1
	virtual/java-scheme-2"
SLOT="1.3"
LICENSE="sun-bcla"
KEYWORDS="x86 ppc -sparc -sparc64"

src_unpack () {
	if [ $PLATFORM = "ppc" ]; then
		tail +400 ${DISTDIR}/${MY_P} > j2sdk-1.3.1-ppc.tar.bz2
		tar -xjf j2sdk-1.3.1-ppc.tar.bz2
	else
		unpack ${MY_P}
	fi
}


src_install () {

	dodir /opt/${P}

	cp -dpR ${S}/{bin,jre,lib,man,include,include-old} ${D}/opt/${P}

	dodir /opt/${P}/share/java
	cp -R ${S}/{demo,src.jar} ${D}/opt/${P}/share
	
	dodoc COPYRIGHT LICENSE README INSTALL
	dohtml README.html

	# Install mozilla plugin
	install_mozilla_plugin /opt/${P}/jre/plugin/${PLATFORM}/mozilla/javaplugin_oji.so 

	find ${D}/opt/${P} -type f -name "*.so" -exec chmod +x \{\} \;

	mv ${D}/opt/${P}/jre/lib/font.properties ${D}/opt/${P}/jre/lib/font.properties.orig
	sed "s/standard symbols l/symbol/g" \
		< ${D}/opt/${P}/jre/lib/font.properties.orig \
		> ${D}/opt/${P}/jre/lib/font.properties
	rm ${D}/opt/${P}/jre/lib/font.properties.orig
	
	# install env into /etc/env.d
	set_java_env ${FILESDIR}/${VMHANDLE} || die
}

pkg_postinst () {
	# Set as default system VM if none exists
	java_pkg_postinst

	if [ -z "`use mozilla`" ] ; then
		einfo "For instructions on installing the ${P} browser plugin for"
		einfo "Netscape and Mozilla, see /usr/share/doc/${P}/INSTALL."
	fi
}

