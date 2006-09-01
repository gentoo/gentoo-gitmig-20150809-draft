# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/sun-jdk/sun-jdk-1.5.0.08.ebuild,v 1.3 2006/09/01 03:25:39 nichoj Exp $

inherit java-vm-2 eutils

MY_PVL=${PV%.*}_${PV##*.}
MY_PVA=${PV//./_}
S="${WORKDIR}/jdk${MY_PVL}"

X86_AT="jdk-${MY_PVA}-dlj-linux-i586.bin"
AMD64_AT="jdk-${MY_PVA}-dlj-linux-amd64.bin"
if use x86; then
	At=${X86_AT}
elif use amd64; then
	At=${AMD64_AT}
fi
DESCRIPTION="Sun's J2SE Development Kit, version ${PV}"
HOMEPAGE="http://java.sun.com/j2se/1.5.0/"
SRC_URI="x86? ( http://download.java.net/dlj/binaries/${X86_AT} )
		amd64? ( http://download.java.net/dlj/binaries/${AMD64_AT} )"
SLOT="1.5"
LICENSE="dlj-1.1"
KEYWORDS="~x86 ~amd64 -*"
RESTRICT="nostrip"
IUSE="X alsa doc examples jce nsplugin"

QA_TEXTRELS_x86="opt/${P}/jre/lib/i386/motif21/libmawt.so opt/${P}/jre/lib/i386/libdeploy.so"

DEPEND=">=dev-java/java-config-1.2
	sys-apps/sed
	doc? ( =dev-java/java-sdk-docs-1.5.0* )
	jce? ( =dev-java/sun-jce-bin-1.5.0* )"

RDEPEND="alsa? ( media-libs/alsa-lib )
	doc? ( =dev-java/java-sdk-docs-1.5.0* )
	X? ( || ( ( x11-libs/libICE
				x11-libs/libSM
		 		x11-libs/libX11
				x11-libs/libXau
				x11-libs/libXdmcp
				x11-libs/libXext
				x11-libs/libXi
				x11-libs/libXp
				x11-libs/libXt
				x11-libs/libXtst
			  )
				virtual/x11
			)
		)"

JAVA_PROVIDE="jdbc-stdext jdbc-rowset"

PACKED_JARS="lib/tools.jar jre/lib/rt.jar jre/lib/jsse.jar jre/lib/charsets.jar jre/lib/ext/localedata.jar jre/lib/plugin.jar jre/lib/javaws.jar jre/lib/deploy.jar"

# this is needed for proper operating under a PaX kernel without activated grsecurity acl
CHPAX_CONSERVATIVE_FLAGS="pemsv"

#FETCH_SDK="http://javashoplm.sun.com/ECom/docs/Welcome.jsp?StoreId=22&PartDetailId=jdk-${MY_PVL}-oth-JPR&SiteId=JSC&TransactionId=noreg"
#FETCH_JCE="http://javashoplm.sun.com/ECom/docs/Welcome.jsp?StoreId=22&PartDetailId=jce_policy-${PV%.*}-oth-JPR&SiteId=JSC&TransactionId=noreg"


src_unpack() {
	if [ ! -r ${DISTDIR}/${At} ]; then
		die "cannot read ${At}. Please check the permission and try again."
	fi
#	if use jce; then
#		if [ ! -r ${DISTDIR}/${jcefile} ]; then
#			die "cannot read ${jcefile}. Please check the permission and try again."
#		fi
#	fi

	sh ${DISTDIR}/${At} --accept-license --unpack || die "Failed to unpack"

	${S}/bin/java -client -Xshare:dump
}

src_install() {
	local dirs="bin include jre lib man"
	dodir /opt/${P}

	for i in $dirs ; do
		cp -pPR $i ${D}/opt/${P}/ || die "failed to copy"
	done
	dodoc COPYRIGHT README.html
	dohtml README.html
	dodir /opt/${P}/share/

	cp -pPR src.zip ${D}/opt/${P}/share/

	if use examples; then
		cp -pPR demo ${D}/opt/${P}/share/
		if ( use x86 || use amd64 ); then
			cp -pPR sample ${D}/opt/${P}/share/
		fi
	fi

	if use jce; then
		cd ${D}/opt/${P}/jre/lib/security
		dodir /opt/${P}/jre/lib/security/strong-jce
		mv ${D}/opt/${P}/jre/lib/security/US_export_policy.jar ${D}/opt/${P}/jre/lib/security/strong-jce
		mv ${D}/opt/${P}/jre/lib/security/local_policy.jar ${D}/opt/${P}/jre/lib/security/strong-jce
		dosym /opt/sun-jce-bin-1.5.0/jre/lib/security/unlimited-jce/US_export_policy.jar /opt/${P}/jre/lib/security/
		dosym /opt/sun-jce-bin-1.5.0/jre/lib/security/unlimited-jce/local_policy.jar /opt/${P}/jre/lib/security/
	fi

	if use nsplugin; then
		local plugin_dir="ns7-gcc29"
		if has_version '>=sys-devel/gcc-3' ; then
			plugin_dir="ns7"
		fi

		if use x86 ; then
			install_mozilla_plugin /opt/${P}/jre/plugin/i386/$plugin_dir/libjavaplugin_oji.so
		else
			eerror "No plugin available for amd64 arch"
		fi
	fi

	# create dir for system preferences
	dodir /opt/${P}/jre/.systemPrefs
	# Create files used as storage for system preferences.
	touch ${D}/opt/${P}/jre/.systemPrefs/.system.lock
	chmod 644 ${D}/opt/${P}/jre/.systemPrefs/.system.lock
	touch ${D}/opt/${P}/jre/.systemPrefs/.systemRootModFile
	chmod 644 ${D}/opt/${P}/jre/.systemPrefs/.systemRootModFile

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

		# /opt/$VM/jre/bin/java_vm
		chpax -${CHPAX_CONSERVATIVE_FLAGS} /opt/${P}/jre/bin/java_vm

		einfo "you should have seen lots of chpax output above now"
		ewarn "make sure the grsec ACL contains those entries also"
		ewarn "because enabling it will override the chpax setting"
		ewarn "on the physical files - help for PaX and grsecurity"
		ewarn "can be given by #gentoo-hardened + hardened@gentoo.org"
	fi

	if ! use X; then
		local xwarn="virtual/x11 and/or"
	fi

	echo
	ewarn "Some parts of Sun's JDK require ${xwarn} virtual/lpr to be installed."
	ewarn "Be careful which Java libraries you attempt to use."

	echo
	einfo " Be careful: ${P}'s Java compiler uses"
	einfo " '-source 1.5' as default. Some keywords such as 'enum'"
	einfo " are not valid identifiers any more in that mode,"
	einfo " which can cause incompatibility with certain sources."
}
