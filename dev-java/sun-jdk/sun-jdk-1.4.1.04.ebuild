# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/sun-jdk/sun-jdk-1.4.1.04.ebuild,v 1.3 2003/08/24 02:23:53 strider Exp $

# Since This Ebuild Has FETCH restrictions:
# You need to download this file from 
# http://java.sun.com/j2se/1.4.1/download.html 
# and copy it on your distfiles directory and emerge it again

IUSE="doc"

inherit java nsplugins

At="j2sdk-1_4_1_04-linux-i586.bin"
S="${WORKDIR}/j2sdk1.4.1_04"
DESCRIPTION="Sun's J2SE Development Kit, version 1.4.1_04"
HOMEPAGE="http://java.sun.com/j2se/1.4.1/download.html"
SRC_URI=${At}
RESTRICT="fetch"
SLOT="1.4"
LICENSE="sun-bcla-java-vm"
KEYWORDS="x86 -ppc -sparc -alpha -mips -hppa -arm"

DEPEND=">=dev-java/java-config-0.2.7
	doc? ( =dev-java/java-sdk-docs-1.4.1* )"

RDEPEND="sys-libs/lib-compat"

PROVIDE="virtual/jre-1.4
	virtual/jdk-1.4
	virtual/java-scheme-2"

pkg_nofetch() {
	einfo "Please download ${At} from:"
	einfo ${HOMEPAGE}
	einfo "(select the \"Linux self-extracting file\" package format of the SDK)"
	einfo "and move it to ${DISTDIR}"
}

src_unpack() {
	startAt=`grep -aonm 1 ELF ${DISTDIR}/${At} | cut -d: -f1`
	tail +${startAt} ${DISTDIR}/${At} > install.sfx
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
		dosym /opt/${P}/jre/plugin/i386/ns610/libjavaplugin_oji.so /usr/lib/mozilla/plugins/
	fi

	set_java_env ${FILESDIR}/${VMHANDLE}
}

pkg_postinst () {
	# Set as default VM if none exists
	java_pkg_postinst

	inst_plugin /opt/${P}/jre/plugin/i386/ns610/libjavaplugin_oji.so
}
