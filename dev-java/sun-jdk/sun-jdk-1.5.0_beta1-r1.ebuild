# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/sun-jdk/sun-jdk-1.5.0_beta1-r1.ebuild,v 1.1 2004/02/15 06:57:19 strider Exp $

IUSE="doc gnome kde mozilla"

inherit java

amd64file="j2sdk-1_5_0-beta-linux-amd64.bin"
x86file="j2sdk-1_5_0-beta-linux-i586.bin"

if [ `use x86` ]; then
	At=${x86file}
elif [ `use amd64` ]; then
	At=${amd64file}
fi

S="${WORKDIR}/j2sdk1.5.0"
DESCRIPTION="Sun's J2SE Development Kit, version ${PV}"
HOMEPAGE="http://java.sun.com/j2se/1.5.0/download.jsp"
SRC_URI="x86? ( $x86file ) amd64? ( $amd64file )"
SLOT="1.5"
LICENSE="sun-bcla-java-vm"
KEYWORDS="~x86 ~amd64"
RESTRICT="fetch"

#
DEPEND=">=dev-java/java-config-1.2
	sys-apps/sed
	doc? ( =dev-java/java-sdk-docs-1.5.0* )
	virtual/lpr"

RDEPEND="x86? ( sys-libs/lib-compat )
	doc? ( =dev-java/java-sdk-docs-1.5.0* )
	virtual/lpr"

PROVIDE="virtual/jre-1.5
	virtual/jdk-1.5"

PACKED_JARS="lib/tools.jar jre/lib/rt.jar jre/lib/jsse.jar jre/lib/charsets.jar jre/lib/ext/localedata.jar jre/lib/plugin.jar jre/lib/javaws.jar jre/lib/deploy.jar"

# this is needed for proper operating under a PaX kernel without activated grsecurity acl
CHPAX_CONSERVATIVE_FLAGS="pemsv"

pkg_nofetch() {
	einfo "Please download ${At} from:"
	einfo ${HOMEPAGE}
	einfo "(SDK 32-bit/64-bit for Windows/Linux/Solaris SPARC 32-bit for Solaris x86, then select download Linux Self-extracting or Linux AMD64 self-extracting, depending on your arch.)"
	einfo "and move it to ${DISTDIR}"
}

src_unpack() {
	if [ ! -r ${DISTDIR}/${At} ]; then
		eerror "cannot read ${At}. Please check the permission and try again."
		die
	fi
	#Search for the ELF Header
	testExp=`echo -e "\105\114\106"`
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
		rm -f ${UNPACK_CMD}
	else
		die "unpack not found"
	fi
	${S}/bin/java -client -Xshare:dump
}

src_install () {
	local dirs="bin include jre lib man"
	dodir /opt/${P}

	for i in $dirs ; do
		cp -a $i ${D}/opt/${P}/
	done
	dodoc COPYRIGHT LICENSE README.html
	dohtml README.html
	dodir /opt/${P}/share/
	cp -a demo src.zip ${D}/opt/${P}/share/
	if [ "`use x86`" ]; then
		cp -a sample ${D}/opt/${P}/share/
	fi

	local plugin_dir="ns7-gcc29"
	if has_version '>=gcc-3*' ; then
		plugin_dir="ns7"
	fi

	if [ "`use mozilla`" ] ; then
		if [ "`use x86`" ] ; then
			install_mozilla_plugin /opt/${P}/jre/plugin/i386/$plugin_dir/libjavaplugin_oji.so
		else
			eerror "No plugin available for amd64 arch"
		fi
	fi

	# create dir for system preferences
	dodir /opt/${P}/.systemPrefs

	# install control panel for Gnome/KDE
	sed -e "s/INSTALL_DIR\/JRE_NAME_VERSION/\/opt\/${P}\/jre/" \
		-e "s/\(Name=Java\)/\1 Control Panel/" \
		${D}/opt/${P}/jre/plugin/desktop/sun_java.desktop > \
		${T}/sun_java.desktop

	if [ "`use x86`" ]; then
		if [ "`use gnome`" ] ; then
			#TODO check this on Gnome
			dodir /usr/share/gnome/apps/Internet
			insinto /usr/share/gnome/apps/Internet
			doins ${T}/sun_java.desktop
		fi

		if [ "`use kde`" ] ; then
			dodir /usr/share/applnk/Internet
			insinto /usr/share/applnk/Internet
			doins ${T}/sun_java.desktop
		fi
	else
		eerror "Sorry no kde, gnome support for your arch now."
	fi

	set_java_env ${FILESDIR}/${VMHANDLE}

	# TODO prepman "fixes" symlink ja -> ja__JP.eucJP in 'man' directory,
	#      creating ja.gz -> ja_JP.eucJP.gz. This is broken as ja_JP.eucJP
	#      is a directory and will not be gzipped ;)
}

pkg_postinst () {
	# Create files used as storage for system preferences.
	PREFS_LOCATION=/opt/${P}/jre
	mkdir -p ${PREFS_LOCATION}/.systemPrefs
	if [ ! -f ${PREFS_LOCATION}/.systemPrefs/.system.lock ] ; then
		touch $PREFS_LOCATION/.systemPrefs/.system.lock
		chmod 644 $PREFS_LOCATION/.systemPrefs/.system.lock
	fi
	if [ ! -f $PREFS_LOCATION/.systemPrefs/.systemRootModFile ] ; then
		touch $PREFS_LOCATION/.systemPrefs/.systemRootModFile
		chmod 644 $PREFS_LOCATION/.systemPrefs/.systemRootModFile
	fi

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

		for paxkills in "jar" "javac" "java"
		do
			chpax -${CHPAX_CONSERVATIVE_FLAGS} /opt/${PN}-${PV}/bin/$paxkills
		done

		# /opt/$VM/jre/bin/java_vm
		chpax -${CHPAX_CONSERVATIVE_FLAGS} /opt/${PN}-${PV}/jre/bin/java_vm

		einfo "you should have seen lots of chpax output above now"
		ewarn "make sure the grsec ACL contains those entries also"
		ewarn "because enabling it will override the chpax setting"
		ewarn "on the physical files - help for PaX and grsecurity"
		ewarn "can be given by #gentoo-hardened + pappy@gentoo.org"
	fi

	#Thanks to Douglas Pollock <douglas.pollock@magma.ca> for this
	#comment found on the sun-jdk 1.2.2 ebuild that he sent.
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
