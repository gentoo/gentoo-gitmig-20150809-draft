# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/sun-jdk/sun-jdk-1.3.1.09.ebuild,v 1.6 2004/01/10 18:26:14 strider Exp $

IUSE="doc"

inherit java nsplugins

At="j2sdk-1_3_1_09-linux-i586.bin"
S="${WORKDIR}/jdk1.3.1_09"
SRC_URI="${At}"
DESCRIPTION="Sun Java Development Kit 1.3.1_09"
HOMEPAGE="http://java.sun.com/j2se/1.3/download.html"
DEPEND="virtual/glibc
	>=dev-java/java-config-0.2.7
	doc? ( =dev-java/java-sdk-docs-1.3.1* )"
RDEPEND="sys-libs/lib-compat"
PROVIDE="virtual/jre-1.3.1
	virtual/jdk-1.3.1
	virtual/java-scheme-2"
LICENSE="sun-bcla-java-vm"
SLOT="1.3"
KEYWORDS="x86 -ppc -sparc -alpha -mips -hppa -arm"
RESTRICT="fetch"

# this is needed for proper operating under a PaX kernel without activated grsecurity acl
CHPAX_CONSERVATIVE_FLAGS="pemsv"

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
	#Search for the ELF Header
	testExp=`echo -e "\177\105\114\106\001\001\001"`
	startAt=`grep -aonm 1 ${testExp}  ${DISTDIR}/${At} | cut -d: -f1`
	tail -n +${startAt} ${DISTDIR}/${At} > install.sfx
	chmod +x install.sfx
	./install.sfx
	rm install.sfx
}

src_install () {
	local dirs="bin include include-old jre lib"
	dodir /opt/${P}

	for i in ${dirs} ; do
		if [ "${i}" == "bin" ] ; then
			dodir /opt/${P}/${i}
			cp -a ${i}/.java_wrapper ${D}/opt/${P}/bin/
			cp -a ${i}/* ${D}/opt/${P}/bin/
		elif [ "${i}" == "jre" ] ; then
			dodir /opt/${P}/${i}
			dodir /opt/${P}/${i}/bin
			cp -a ${i}/bin/.java_wrapper ${D}/opt/${P}/${i}/bin/
			cp -a ${i}/bin/* ${D}/opt/${P}/${i}/bin/
			cp -a 	${i}/CHANGES \
				${i}/COPYRIGHT \
				${i}/ControlPanel.html \
				${i}/LICENSE \
				${i}/README \
				${i}/Welcome.html \
				${i}/lib \
				${i}/plugin \
				${D}/opt/${P}/${i}/
		else
			cp -a ${i} ${D}/opt/${P}/
		fi
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

	# if chpax is on the target system, set the appropriate PaX flags
	# this will not hurt the binary, it modifies only unused ELF bits
	# but may confuse things like AV scanners and automatic tripwire
	if has_version "sys-apps/chpax"
	then
		einfo "setting up conservative PaX flags for jar, javac and java"

		for paxkills in "jar" "javac" "java"
		do
			chpax -${CHPAX_CONSERVATIVE_FLAGS} /opt/${PN}-${PV}/bin/$paxkills
		done

		# /opt/sun-jdk-1.3.1.09/jre/bin/java_vm
		chpax -${CHPAX_CONSERVATIVE_FLAGS} /opt/${PN}-${PV}/jre/bin/java_vm

		einfo "you should have seen lots of chpax output above now"
		ewarn "make sure the grsec ACL contains those entries also"
		ewarn "because enabling it will override the chpax setting"
		ewarn "on the physical files - help for PaX and grsecurity"
		ewarn "can be given by #gentoo-hardened + pappy@gentoo.org"
	fi

	#Thanks to Douglas Pollock <douglas.pollock@magma.ca> for this
	#comment found on the sun-jdk 1.2.2 ebuild that he sent.
	einfo "********************************************************"
	eerror "Some parts of Sun's JDK require XFree86 to be installed."
	eerror "Be careful which Java libraries you attempt to use."
	einfo "********************************************************"
	echo

	einfo "******************************************************"
	einfo " After installing ${P} this"
	einfo " was set as the default JVM to run."
	einfo " When finished please run the following so your"
	einfo " enviroment gets updated."
	eerror "    /usr/sbin/env-update && source /etc/profile"
	einfo " Or use java-config program to set your preferred VM"
	einfo "******************************************************"

	echo -ne "\a" ; sleep 0.1 &>/dev/null ; sleep 0,1 &>/dev/null
	echo -ne "\a" ; sleep 1
	echo -ne "\a" ; sleep 0.1 &>/dev/null ; sleep 0,1 &>/dev/null
	echo -ne "\a" ; sleep 1
	sleep 8
}
