# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/sun-jre/sun-jre-1.4.2.03.ebuild,v 1.1 2004/02/12 18:58:04 lostlogic Exp $

IUSE="doc gnome kde mozilla"

inherit java nsplugins

At="j2re-1_4_2_03-linux-i586.bin"
S="${WORKDIR}/j2re1.4.2_03"
DESCRIPTION="Sun's J2SE Platform, version 1.4.2_03"
HOMEPAGE="http://java.sun.com/j2se/1.4.2/download.html"
SRC_URI=${At}
SLOT="1.4"
LICENSE="sun-bcla-java-vm"
KEYWORDS="~x86 -ppc -sparc -alpha -mips -hppa -arm"
RESTRICT="fetch"

DEPEND=">=dev-java/java-config-1.1.5
	sys-apps/sed"

RDEPEND="sys-libs/lib-compat"

PROVIDE="virtual/jre-1.4.2
	virtual/java-scheme-2"

PACKED_JARS="lib/rt.jar lib/jsse.jar lib/charsets.jar
lib/ext/localedata.jar lib/plugin.jar javaws/javaws.jar"

# this is needed for proper operating under a PaX kernel without activated grsecurity acl
CHPAX_CONSERVATIVE_FLAGS="pemsv"

pkg_nofetch() {
	einfo "Please download ${At} from:"
	einfo ${HOMEPAGE}
	einfo "(select the \"Linux self-extracting file\" package format of the JRE"
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
	./install.sfx || die
	rm install.sfx

	if [ -f ${S}/lib/unpack ]; then
		UNPACK_CMD=${S}/lib/unpack
		chmod +x $UNPACK_CMD
		for i in $PACKED_JARS; do
			PACK_FILE=${S}/`dirname $i`/`basename $i .jar`.pack
			if [ -f ${PACK_FILE} ]; then
				echo "	unpacking: $i"
				$UNPACK_CMD ${PACK_FILE} ${S}/$i
				rm -f ${PACK_FILE}
			fi
		done
	fi
}

src_install () {
	local dirs="bin lib man javaws plugin"
	dodir /opt/${P}

	for i in $dirs ; do
		cp -a $i ${D}/opt/${P}/
	done

	dodoc CHANGES COPYRIGHT README LICENSE THIRDPARTYLICENSEREADME.txt
	dohtml Welcome.html ControlPanel.html

	local plugin_dir="ns610"
	if has_version '>=gcc-3.2*' ; then
		plugin_dir="ns610-gcc32"
	fi
	if [ "`use mozilla`" ] ; then
		install_mozilla_plugin /opt/${P}/plugin/i386/$plugin_dir/libjavaplugin_oji.so
	fi
	inst_plugin /opt/${P}/plugin/i386/$plugin_dir/libjavaplugin_oji.so

	# create dir for system preferences
	dodir /opt/${P}/.systemPrefs

	# install control panel for Gnome/KDE
	sed -e "s/INSTALL_DIR\/JRE_NAME_VERSION/\/opt\/${P}/" \
		-e "s/\(Name=Java\)/\1 Control Panel/" \
		${D}/opt/${P}/plugin/desktop/sun_java.desktop > \
		${T}/sun_java.desktop

	if use gnome ; then
		#TODO check this on Gnome
		dodir /usr/share/gnome/apps/Internet
		insinto /usr/share/gnome/apps/Internet
		doins ${T}/sun_java.desktop
	fi
	if use kde ; then
		dodir $KDEDIR/share/applnk/Internet
		insinto $KDEDIR/share/applnk/Internet
		doins ${T}/sun_java.desktop
	fi

	set_java_env ${FILESDIR}/${VMHANDLE}

	# TODO prepman "fixes" symlink ja -> ja__JP.eucJP in 'man' directory,
	#      creating ja.gz -> ja_JP.eucJP.gz. This is broken as ja_JP.eucJP
	#      is a directory and will not be gzipped ;)
}

pkg_postinst () {
	# Create files used as storage for system preferences.
	touch /opt/${P}/.systemPrefs/.system.lock
	chmod 644 /opt/${P}/.systemPrefs/.system.lock
	touch /opt/${P}/.systemPrefs/.systemRootModFile
	chmod 644 /opt/${P}/.systemPrefs/.systemRootModFile

	# Set as default VM if none exists
	java_pkg_postinst

	#Show info about netscape
	if has_version '>=netscape-navigator-4.79-r1' || has_version '>=netscape-communicator-4.79-r1' ; then
		einfo "********************************************************"
		einfo "If you want to install the plugin for Netscape 4.x, type"
		einfo
		einfo "   cd /usr/lib/nsbrowser/plugins/"
		einfo "   ln -sf /opt/${P}/jre/plugin/i386/ns4/libjavaplugin.so"
		einfo "********************************************************"
		echo
	fi

	# if chpax is on the target system, set the appropriate PaX flags
	# this will not hurt the binary, it modifies only unused ELF bits
	# but may confuse things like AV scanners and automatic tripwire
	if has_version "sys-apps/chpax"
	then
		einfo "setting up conservative PaX flags for jar, javac and java"

		for paxkills in "java"
		do
			chpax -${CHPAX_CONSERVATIVE_FLAGS} /opt/${PN}-${PV}/bin/$paxkills
		done

		# /opt/sun-jdk-1.4.2.03/bin/java_vm
		chpax -${CHPAX_CONSERVATIVE_FLAGS} /opt/${PN}-${PV}/bin/java_vm

		einfo "you should have seen lots of chpax output above now"
		ewarn "make sure the grsec ACL contains those entries also"
		ewarn "because enabling it will override the chpax setting"
		ewarn "on the physical files - help for PaX and grsecurity"
		ewarn "can be given by #gentoo-hardened + pappy@gentoo.org"
	fi

	#Thanks to Douglas Pollock <douglas.pollock@magma.ca> for this
	#comment found on the sun-jre 1.2.2 ebuild that he sent.
	einfo "*********************************************************"
	eerror "Some parts of Sun's JDK require XFree86 to be installed."
	eerror "Be careful which Java libraries you attempt to use."
	einfo "*********************************************************"
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
