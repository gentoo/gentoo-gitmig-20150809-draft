# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/sun-jdk/sun-jdk-1.4.1.06.ebuild,v 1.3 2004/02/15 06:57:19 strider Exp $

IUSE="doc"

inherit java nsplugins

At="j2sdk-1_4_1_06-linux-i586.bin"
S="${WORKDIR}/j2sdk1.4.1_06"
DESCRIPTION="Sun's J2SE Development Kit, version 1.4.1_06"
HOMEPAGE="http://java.sun.com/j2se/1.4.1/download.html"
SRC_URI=${At}
RESTRICT="fetch"
SLOT="1.4"
LICENSE="sun-bcla-java-vm"
KEYWORDS="x86 -ppc -sparc -alpha -mips -hppa -arm"

DEPEND=">=dev-java/java-config-1.1.5
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
	if [ ! -r ${DISTDIR}/${At} ]; then
		eerror "cannot read ${At}. Please check the permission and try again."
		die
	fi

	#Thanks to Douglas Pollock <douglas.pollock@magma.ca> for this
	#comment found on the sun-jdk 1.2.2 ebuild that he sent.	
	ewarn "WARNING:"
	ewarn "Sun's JDK 1.4.1 series has begun the Sun End of Life (EOL)"
	ewarn "process. The EOL transition period is from July 15, 2003 "
	ewarn "until January 15, 2004. Sun is advising users to move to"
	ewarn "more recent JDK versions."
	echo
	sleep 8

	#Search for the ELF Header
	testExp=`echo -e "\177\105\114\106\001\001\001"`
	startAt=`grep -aonm 1 ${testExp}  ${DISTDIR}/${At} | cut -d: -f1`
	tail -n +${startAt} ${DISTDIR}/${At} > install.sfx
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

	#Thanks to Douglas Pollock <douglas.pollock@magma.ca> for this
	#comment found on the sun-jdk 1.2.2 ebuild that he sent.
	einfo "********************************************************"
	eerror "Some parts of Sun's JDK require XFree86 to be installed."
	eerror "Be careful which Java libraries you attempt to use."
	einfo "********************************************************"
	echo

	einfo "********************************************************"
	einfo " After installing ${P} this"
	einfo " was set as the default JVM to run."
	einfo " When finished please run the following so your"
	einfo " enviroment gets updated."
	eerror "    /usr/sbin/env-update && source /etc/profile"
	einfo " Or use java-config program to set your preferred VM"
	einfo "********************************************************"

	echo -ne "\a" ; sleep 0.1 &>/dev/null ; sleep 0,1 &>/dev/null
	echo -ne "\a" ; sleep 1
	echo -ne "\a" ; sleep 0.1 &>/dev/null ; sleep 0,1 &>/dev/null
	echo -ne "\a" ; sleep 1
	sleep 8
}
