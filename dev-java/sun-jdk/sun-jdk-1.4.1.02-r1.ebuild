# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/sun-jdk/sun-jdk-1.4.1.02-r1.ebuild,v 1.2 2003/05/24 06:19:45 absinthe Exp $

IUSE="doc"

inherit java nsplugins

At="j2sdk-1_4_1_02-linux-i586.bin"
S="${WORKDIR}/j2sdk1.4.1_02"
DESCRIPTION="Sun's J2SE Development Kit, version 1.4.1_02"
HOMEPAGE="http://java.sun.com/j2se/1.4.1/download.html"
SRC_URI=""

SLOT="1.4"
LICENSE="sun-bcla-java-vm"
KEYWORDS="x86 -ppc -sparc -alpha -mips -hppa -arm"

DEPEND=">=dev-java/java-config-0.2.5
	doc? ( =dev-java/java-sdk-docs-1.4.1* )"

RDEPEND="sys-libs/lib-compat"

PROVIDE="virtual/jre-1.4
	virtual/jdk-1.4
	virtual/java-scheme-2"

src_unpack() {
	if [ ! -f ${DISTDIR}/${At} ] ; then
		die "Please download ${At} from ${HOMEPAGE} (select the \"Linux self-extracting file\" package format of the SDK) and move it to ${DISTDIR}"
	fi
	tail +430 ${DISTDIR}/${At} > install.sfx
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
