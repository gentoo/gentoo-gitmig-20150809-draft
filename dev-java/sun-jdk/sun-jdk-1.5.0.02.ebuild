# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/sun-jdk/sun-jdk-1.5.0.02.ebuild,v 1.1 2005/03/21 18:20:11 axxo Exp $

inherit java eutils

MY_PVL=${PV%.*}_${PV##*.}
MY_PVA=${PV//./_}

amd64file="jdk-${MY_PVA}-linux-amd64.bin"
x86file="jdk-${MY_PVA}-linux-i586.bin"

jcefile="jce_policy-${MY_PVA%_*}.zip"

if use x86; then
	At=${x86file}
elif use amd64; then
	At=${amd64file}
fi

S="${WORKDIR}/jdk${MY_PVL}"
DESCRIPTION="Sun's J2SE Development Kit, version ${PV}"
HOMEPAGE="http://java.sun.com/j2se/1.5.0/"
SRC_URI="x86? ( $x86file ) amd64? ( $amd64file )
		jce? ( $jcefile )"
SLOT="1.5"
LICENSE="sun-bcla-java-vm"
KEYWORDS="~x86 ~amd64"
RESTRICT="fetch nostrip"
IUSE="doc gnome kde mozilla jce"

#
DEPEND=">=dev-java/java-config-1.2
	sys-apps/sed
	jce? ( app-arch/unzip )
	doc? ( =dev-java/java-sdk-docs-1.5.0* )"

RDEPEND="x86? ( sys-libs/lib-compat )
	doc? ( =dev-java/java-sdk-docs-1.5.0* )"

PROVIDE="virtual/jre-1.5
	virtual/jdk-1.5"

PACKED_JARS="lib/tools.jar jre/lib/rt.jar jre/lib/jsse.jar jre/lib/charsets.jar jre/lib/ext/localedata.jar jre/lib/plugin.jar jre/lib/javaws.jar jre/lib/deploy.jar"

# this is needed for proper operating under a PaX kernel without activated grsecurity acl
CHPAX_CONSERVATIVE_FLAGS="pemsv"

FETCH_SDK="http://javashoplm.sun.com/ECom/docs/Welcome.jsp?StoreId=22&PartDetailId=jdk-${MY_PVL}-oth-JPR&SiteId=JSC&TransactionId=noreg"
FETCH_JCE="http://javashoplm.sun.com/ECom/docs/Welcome.jsp?StoreId=22&PartDetailId=jce_policy-${PV%.*}-oth-JPR&SiteId=JSC&TransactionId=noreg"


pkg_nofetch() {
	einfo "Please download ${At} from:"
	einfo ${FETCH_SDK}
	einfo "(Select the Self-extracting (.bin) for Linux or Linux AMD64, depending on your arch)"
	einfo "and move it to ${DISTDIR}"

	if use jce; then
		echo
		einfo "Also download ${jcefile} from:"
		einfo ${FETCH_JCE}
		einfo "Java(TM) Cryptography Extension (JCE) Unlimited Strength Jurisdiction Policy Files"
		einfo "and move it to ${DISTDIR}"
	fi

}

src_unpack() {
	if [ ! -r ${DISTDIR}/${At} ]; then
		die "cannot read ${At}. Please check the permission and try again."
	fi
	if use jce; then
		if [ ! -r ${DISTDIR}/${jcefile} ]; then
			die "cannot read ${jcefile}. Please check the permission and try again."
		fi
	fi

	#Search for the ELF Header
	testExp=`echo -e "\105\114\106"`
	startAt=`grep -aonm 1 ${testExp}  ${DISTDIR}/${At} | cut -d: -f1`
	tail -n +${startAt} ${DISTDIR}/${At} > install.sfx
	chmod +x install.sfx
	./install.sfx || die
	rm install.sfx

	if [ -f ${S}/bin/unpack200 ]; then
		UNPACK_CMD=${S}/bin/unpack200
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

src_install() {
	local dirs="bin include jre lib man"
	dodir /opt/${P}

	for i in $dirs ; do
		cp -a $i ${D}/opt/${P}/ || die "failed to copy"
	done
	dodoc COPYRIGHT LICENSE README.html
	dohtml README.html
	dodir /opt/${P}/share/
	cp -a demo src.zip ${D}/opt/${P}/share/
	if ( use x86 || use amd64 ); then
		cp -a sample ${D}/opt/${P}/share/
	fi

	if use jce ; then
		cd ${D}/opt/${P}/jre/lib/security
		unzip ${DISTDIR}/${jcefile} || die "failed to unzip jce"
		mv jce unlimited-jce
		dodir /opt/${P}/jre/lib/security/strong-jce
		mv ${D}/opt/${P}/jre/lib/security/US_export_policy.jar ${D}/opt/${P}/jre/lib/security/strong-jce
		mv ${D}/opt/${P}/jre/lib/security/local_policy.jar ${D}/opt/${P}/jre/lib/security/strong-jce
		dosym /opt/${P}/jre/lib/security/unlimited-jce/US_export_policy.jar /opt/${P}/jre/lib/security/
		dosym /opt/${P}/jre/lib/security/unlimited-jce/local_policy.jar /opt/${P}/jre/lib/security/
	fi

	if use mozilla; then
		local plugin_dir="ns7-gcc29"
		if has_version '>=gcc-3*' ; then
			plugin_dir="ns7"
		fi

		if use x86 ; then
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

	if use x86; then
		if use gnome ; then
			#TODO check this on Gnome
			dodir /usr/share/gnome/apps/Internet
			insinto /usr/share/gnome/apps/Internet
			doins ${T}/sun_java.desktop
		fi

		if use kde ; then
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

pkg_postinst() {
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
		echo
		einfo "If you want to install the plugin for Netscape 4.x, type"
		einfo
		einfo "   cd /usr/lib/nsbrowser/plugins/"
		einfo "   ln -sf /opt/${P}/jre/plugin/i386/ns4/libjavaplugin.so"
	fi

	# if chpax is on the target system, set the appropriate PaX flags
	# this will not hurt the binary, it modifies only unused ELF bits
	# but may confuse things like AV scanners and automatic tripwire
	if has_version "sys-apps/chpax"
	then
		echo
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

	echo
	eerror "Some parts of Sun's JDK require virtual/x11 and/or virtual/lpr to be installed."
	eerror "Be careful which Java libraries you attempt to use."

	echo
	einfo " Be careful: ${P}'s Java compiler uses"
	einfo " '-source 1.5' as default. Some keywords such as 'enum'"
	einfo " are not valid identifiers any more in that mode,"
	einfo " which can cause incompatibility with certain sources."

	ebeep 5
	epause 8
}
