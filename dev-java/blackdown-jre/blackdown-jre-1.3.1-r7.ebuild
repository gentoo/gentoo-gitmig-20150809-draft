# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-java/blackdown-jre/blackdown-jre-1.3.1-r7.ebuild,v 1.5 2002/07/16 21:52:28 karltk Exp $

. /usr/portage/eclass/inherit.eclass
inherit java

case `system_arch` in
	ppc)
		PLATFORM="ppc"
		FCS="FCS-02b"
		MY_P="j2re-1.3.1-02b-FCS-linux-ppc.bin"
		;;

	i386)
		PLATFORM="i386"
		FCS="FCS"
		MY_P="j2re-1.3.1-FCS-linux-i386.tar.bz2"
		;;

	sparc)
		;;

	sparc64)
		;;
esac


S=${WORKDIR}/j2re1.3.1
DESCRIPTION="Blackdown Java Runtime Environment 1.3.1"
SRC_URI="ftp://metalab.unc.edu/pub/linux/devel/lang/java/blackdown.org/JDK-1.3.1/${PLATFORM}/${FCS}/${MY_P}"
HOMEPAGE="http://www.blackdown.org"
DEPEND="virtual/glibc
	>=dev-java/java-config-0.2.0"
RDEPEND="$DEPEND"
PROVIDE="virtual/jre-1.3
	virtual/java-scheme-2"
SLOT="0"
LICENSE=""

src_unpack () {
	if [ $PLATFORM = "ppc" ]; then
		tail +422 ${DISTDIR}/${MY_P} > j2re-1.3.1-ppc.tar.bz2
		tar -xjf j2re-1.3.1-ppc.tar.bz2
	else
		unpack ${MY_P}
	fi
}

src_install () {
	dodir /opt/${P}

	cp -dpR ${S}/{bin,lib,man,plugin} ${D}/opt/${P}/
        find ${D}/opt/${P} -type f -name "*.so" -exec chmod +x \{\} \;

	dodoc COPYRIGHT LICENSE README INSTALL
	dohtml README.html

	install_mozilla_plugin /opt/${P}/plugin/${PLATFORM}/mozilla/javaplugin_oji.so

	mv ${D}/opt/${P}/lib/font.properties ${D}/opt/${P}/lib/font.properties.orig
	sed "s/standard symbols l/symbol/g" \
		< ${D}/opt/${P}/lib/font.properties.orig \
		> ${D}/opt/${P}/lib/font.properties
	rm ${D}/opt/${P}/lib/font.properties.orig

	set_java_env ${FILESDIR}/${VMHANDLE}
}

pkg_postinst () {
	java_pkg_postinst
	if [ -z "`use mozilla`" ] ; then
		einfo "For instructions on installing the ${P} browser plugin for"
		einfo "Netscape and Mozilla, see /usr/share/doc/${P}/INSTALL."
	fi
}

