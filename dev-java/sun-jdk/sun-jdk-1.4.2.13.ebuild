# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/sun-jdk/sun-jdk-1.4.2.13.ebuild,v 1.2 2006/12/23 17:50:19 ticho Exp $

JAVA_SUPPORTS_GENERATION_1="true"
inherit java-vm-2 eutils

MY_PV=${PV%.*}_${PV##*.}
MY_P=j2sdk${MY_PV}
MY_PVB=${PV%.*}

At="j2sdk-${PV//./_}-linux-i586.bin"
jce_policy="jce_policy-${MY_PVB//./_}.zip"

S="${WORKDIR}/${MY_P}"
DESCRIPTION="Sun's J2SE Development Kit"
HOMEPAGE="http://java.sun.com/j2se/1.4.2/"
SRC_URI="${At}
		jce? ( ${jce_policy} )"
SLOT="1.4"
LICENSE="sun-bcla-java-vm"
KEYWORDS="-* x86"
RESTRICT="fetch"
IUSE="X alsa doc examples nsplugin jce"

DEPEND="sys-apps/sed
	app-arch/unzip"

RDEPEND="alsa? ( media-libs/alsa-lib )
	doc? ( =dev-java/java-sdk-docs-1.4.2* )
	X? (
		x11-libs/libICE
		x11-libs/libSM
		x11-libs/libX11
		x11-libs/libXau
		x11-libs/libXdmcp
		x11-libs/libXext
		x11-libs/libXi
		x11-libs/libXp
		x11-libs/libXt
		x11-libs/libXtst
	)"

JAVA_PROVIDE="jdbc-stdext"

PACKED_JARS="lib/tools.jar jre/lib/rt.jar jre/lib/jsse.jar jre/lib/charsets.jar
jre/lib/ext/localedata.jar jre/lib/plugin.jar jre/javaws/javaws.jar"

# this is needed for proper operating under a PaX kernel without activated grsecurity acl
CHPAX_CONSERVATIVE_FLAGS="pemrsv"

DOWNLOAD_URL="http://javashoplm.sun.com/ECom/docs/Welcome.jsp?StoreId=22&PartDetailId=j2sdk-${MY_PV}-oth-JPR&SiteId=JSC&TransactionId=noreg"
DOWNLOAD_URL_JCE="http://javashoplm.sun.com/ECom/docs/Welcome.jsp?StoreId=22&PartDetailId=7503-jce-${MY_PVB}-oth-JPR&SiteId=JSC&TransactionId=noreg"

QA_TEXTRELS_x86="opt/${P}/jre/lib/i386/libawt.so
	opt/${P}/jre/plugin/i386/ns4/libjavaplugin.so
	opt/${P}/jre/plugin/i386/ns610/libjavaplugin_oji.so
	opt/${P}/jre/plugin/i386/ns610-gcc32/libjavaplugin_oji.so"

pkg_nofetch() {
	einfo "Please download ${At} from:"
	einfo ${DOWNLOAD_URL}
	einfo "(first select 'Accept License', then click on 'self-extracting file'"
	einfo "under 'Linux Platform - Java(TM) 2 SDK, Standard Edition')"
	einfo "and move it to ${DISTDIR}"
	if use jce; then
		echo
		einfo "Also download ${jce_policy} from:"
		einfo ${DOWNLOAD_URL_JCE}
		einfo "Java(TM) Cryptography Extension (JCE) Unlimited Strength Jurisdiction Policy Files"
		einfo "and move it to ${DISTDIR}"
	fi
}

src_unpack() {
	if [ ! -r ${DISTDIR}/${At} ]; then
		die "cannot read ${At}.bin. Please check the permission and try again."
	fi
	if use jce; then
		if [ ! -r ${DISTDIR}/${jce_policy} ]; then
			die "cannot read ${jce_policy}. Please check the permission and try again."
		fi
	fi
	#Search for the ELF Header
	testExp=$'\177\105\114\106\001\001\001'
	startAt=`grep -aonm 1 ${testExp}  ${DISTDIR}/${At} | cut -d: -f1`
	tail -n +${startAt} ${DISTDIR}/${At} > install.sfx
	chmod +x install.sfx
	./install.sfx || die
	rm install.sfx

	if [ -f ${S}/lib/unpack ]; then
		UNPACK_CMD=${S}/lib/unpack
		chmod +x $UNPACK_CMD
		sed -i 's#/tmp/unpack.log#/dev/null\x00\x00\x00\x00\x00\x00#g' $UNPACK_CMD
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

src_install() {
	local dirs="bin include jre lib man"
	dodir /opt/${P}

	for i in $dirs ; do
		cp -dPR $i ${D}/opt/${P}/
	done

	dodoc COPYRIGHT README LICENSE THIRDPARTYLICENSEREADME.txt
	dohtml README.html
	dodir /opt/${P}/share/
	if use examples; then
		cp -pPR demo ${D}/opt/${P}/share/
	fi
	cp -pPR src.zip ${D}/opt/${P}/share/

	if use jce ; then
		# Using unlimited jce while still retaining the strong jce
		# May have repercussions when you find you cannot symlink libraries
		# in classpaths.
		cd ${D}/opt/${P}/jre/lib/security
		unzip ${DISTDIR}/${jce_policy}
		mv jce unlimited-jce
		dodir /opt/${P}/jre/lib/security/strong-jce
		mv ${D}/opt/${P}/jre/lib/security/US_export_policy.jar ${D}/opt/${P}/jre/lib/security/strong-jce
		mv ${D}/opt/${P}/jre/lib/security/local_policy.jar ${D}/opt/${P}/jre/lib/security/strong-jce
		dosym /opt/${P}/jre/lib/security/unlimited-jce/US_export_policy.jar /opt/${P}/jre/lib/security/
		dosym /opt/${P}/jre/lib/security/unlimited-jce/local_policy.jar /opt/${P}/jre/lib/security/
	fi

	if use nsplugin; then
		local plugin_dir="ns610"
		if has_version '>=sys-devel/gcc-3.2' ; then
			plugin_dir="ns610-gcc32"
		fi

		install_mozilla_plugin /opt/${P}/jre/plugin/i386/${plugin_dir}/libjavaplugin_oji.so
	fi

	# bug #147259
	dosym ../jre/javaws/javaws /opt/${P}/bin/javaws
	dosym ../javaws/javaws /opt/${P}/jre/bin/javaws

	# create dir for system preferences
	dodir /opt/${P}/.systemPrefs
	# Create files used as storage for system preferences.
	touch ${D}/opt/${P}/.systemPrefs/.system.lock
	chmod 644 ${D}/opt/${P}/.systemPrefs/.system.lock
	touch ${D}/opt/${P}/.systemPrefs/.systemRootModFile
	chmod 644 ${D}/opt/${P}/.systemPrefs/.systemRootModFile

	# install control panel for Gnome/KDE
	sed -e "s/INSTALL_DIR\/JRE_NAME_VERSION/\/opt\/${P}\/jre/" \
		-e "s/\(Name=Java\)/\1 Control Panel ${SLOT}/" \
		${D}/opt/${P}/jre/plugin/desktop/sun_java.desktop > \
		${T}/sun_java-${SLOT}.desktop

	domenu ${T}/sun_java-${SLOT}.desktop

	set_java_env
}

pkg_postinst() {
	# Set as default VM if none exists
	java-vm-2_pkg_postinst

	# if chpax is on the target system, set the appropriate PaX flags
	# this will not hurt the binary, it modifies only unused ELF bits
	# but may confuse things like AV scanners and automatic tripwire
	if has_version sys-apps/chpax
	then
		echo
		einfo "setting up conservative PaX flags for jar, javac and java"

		for paxkills in "jar" "javac" "java" "javah" "javadoc"
		do
			chpax -${CHPAX_CONSERVATIVE_FLAGS} /opt/${P}/bin/$paxkills
		done

		# /opt/sun-jdk-1.4.2.03/jre/bin/java_vm
		chpax -${CHPAX_CONSERVATIVE_FLAGS} /opt/${P}/jre/bin/java_vm

		einfo "you should have seen lots of chpax output above now"
		ewarn "make sure the grsec ACL contains those entries also"
		ewarn "because enabling it will override the chpax setting"
		ewarn "on the physical files - help for PaX and grsecurity"
		ewarn "can be given by #gentoo-hardened + hardened@gentoo.org"
	fi

	if ! use X; then
		echo
		ewarn "Some parts of Sun's JDK require virtual/x11 to be installed."
		ewarn "Be careful which Java libraries you attempt to use."
	fi
}
