# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/sun-jdk/sun-jdk-1.3.1.07.ebuild,v 1.2 2003/04/23 20:21:28 strider Exp $

IUSE="doc"

inherit java nsplugins

At="j2sdk-1_3_1_07-linux-i586.bin"
S="${WORKDIR}/jdk1.3.1_07"
SRC_URI=""
DESCRIPTION="Sun Java Development Kit 1.3.1_07"
HOMEPAGE="http://java.sun.com/j2se/1.3/download.html"
DEPEND="virtual/glibc
	>=dev-java/java-config-0.2.7
	doc? ( =dev-java/java-sdk-docs-1.3.1* )"
RDEPEND="$DEPEND"
PROVIDE="virtual/jre-1.3.1
	virtual/jdk-1.3.1
	virtual/java-scheme-2"
LICENSE="sun-bcla"
SLOT="1.3"
KEYWORDS="x86 -ppc -sparc -alpha -mips -hppa -arm"

src_unpack() {
	if [ ! -f ${DISTDIR}/${At} ] ; then
		die "Please download ${At} from ${HOMEPAGE} (select the \"Linux self-extracting file\" package format of the SDK) and move it to ${DISTDIR}. Note: You can find archived releases from http://java.sun.com/products/archive/"
	fi
	tail +293 ${DISTDIR}/${At} > install.sfx
	chmod +x install.sfx
	./install.sfx
	rm install.sfx
}

src_install () {
	local dirs="bin include include-old jre lib"
	dodir /opt/${P}

	for i in $dirs ; do
		cp -a $i ${D}/opt/${P}/
	done

	dodoc COPYRIGHT README LICENSE
	dohtml README.html

	doman man/man1/*.1

	dodir /opt/${P}/share/
	cp -a demo src.jar ${D}/opt/${P}/share/

	if [ "`use mozilla`" ] ; then
		dodir /usr/lib/mozilla/plugins
		dosym /opt/${P}/jre/plugin/i386/ns600/libjavaplugin_oji.so /usr/lib/mozilla/plugins/
	fi

	set_java_env ${FILESDIR}/${VMHANDLE} || die
}

pkg_postinst () {
	# Set as default VM if none exists
	java_pkg_postinst

	inst_plugin /opt/${P}/jre/plugin/i386/mozilla/libjavaplugin_oji.so
}
