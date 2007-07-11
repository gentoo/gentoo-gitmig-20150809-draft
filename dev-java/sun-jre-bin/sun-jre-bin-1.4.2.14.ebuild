# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/sun-jre-bin/sun-jre-bin-1.4.2.14.ebuild,v 1.4 2007/07/11 19:58:37 mr_bones_ Exp $

inherit java-vm-2 eutils

MY_PV=${PV%.*}_${PV##*.}
MY_PV2=${PV//./_}
At="j2re-${MY_PV2}-linux-i586.bin"
S="${WORKDIR}/j2re${MY_PV}"
DESCRIPTION="Sun's J2SE Platform"
HOMEPAGE="http://java.sun.com/j2se/1.4.2/"
SRC_URI=${At}
SLOT="1.4"
LICENSE="sun-bcla-java-vm-1.4.2"
KEYWORDS="-* x86"
RESTRICT="fetch"
IUSE="X alsa nsplugin"

DEPEND="sys-apps/sed"

RDEPEND="alsa? ( media-libs/alsa-lib )
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

PACKED_JARS="lib/rt.jar lib/jsse.jar lib/charsets.jar
lib/ext/localedata.jar lib/plugin.jar javaws/javaws.jar"

# this is needed for proper operating under a PaX kernel without activated grsecurity acl
CHPAX_CONSERVATIVE_FLAGS="pemsv"

DOWNLOAD_URL="http://javashoplm.sun.com/ECom/docs/Welcome.jsp?StoreId=22&PartDetailId=j2re-${MY_PV}-oth-JPR&SiteId=JSC&TransactionId=noreg"

QA_TEXTRELS_x86="opt/${P}/lib/i386/libawt.so
	opt/${P}/plugin/i386/ns4/libjavaplugin.so
	opt/${P}/plugin/i386/ns610/libjavaplugin_oji.so
	opt/${P}/plugin/i386/ns610-gcc32/libjavaplugin_oji.so"

pkg_nofetch() {
	einfo "Please download ${At} from:"
	einfo ${DOWNLOAD_URL}
	einfo "(accept the license, then click on 'self-extracting file' under 'Linux Platform')"
	einfo "and move it to ${DISTDIR}"
}

src_unpack() {
	if [ ! -r ${DISTDIR}/${At} ]; then
		eerror "cannot read ${At}. Please check the permission and try again."
		die
	fi
	#Search for the ELF Header
	testExp=$(echo -e '\0177\0105\0114\0106\0001\0001\0001')
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
	local dirs="bin lib man javaws plugin"
	dodir /opt/${P}

	for i in $dirs ; do
		cp -pPR $i ${D}/opt/${P}/
	done

	dodoc CHANGES COPYRIGHT README LICENSE THIRDPARTYLICENSEREADME.txt
	dohtml Welcome.html ControlPanel.html

	if use nsplugin; then
		local plugin_dir="ns610"
		if has_version '>=sys-devel/gcc-3.2' ; then
			plugin_dir="ns610-gcc32"
		fi
		install_mozilla_plugin /opt/${P}/plugin/i386/$plugin_dir/libjavaplugin_oji.so
	fi

	# bug #147259
	dosym ../javaws/javaws /opt/${P}/bin/javaws

	# create dir for system preferences
	dodir /opt/${P}/.systemPrefs

	# create dir for system preferences
	dodir /opt/${P}/.systemPrefs
	# Create files used as storage for system preferences.
	touch ${D}/opt/${P}/.systemPrefs/.system.lock
	chmod 644 ${D}/opt/${P}/.systemPrefs/.system.lock
	touch ${D}/opt/${P}/.systemPrefs/.systemRootModFile
	chmod 644 ${D}/opt/${P}/.systemPrefs/.systemRootModFile

	# install control panel for Gnome/KDE
	sed -e "s/INSTALL_DIR\/JRE_NAME_VERSION/\/opt\/${P}/" \
		-e "s/\(Name=Java\)/\1 Control Panel/" \
		${D}/opt/${P}/plugin/desktop/sun_java.desktop > \
		${T}/sun_java-jre.desktop
	domenu ${T}/sun_java-jre.desktop

	set_java_env
}

pkg_postinst () {
	# Set as default VM if none exists
	java-vm-2_pkg_postinst

	# if chpax is on the target system, set the appropriate PaX flags
	# this will not hurt the binary, it modifies only unused ELF bits
	# but may confuse things like AV scanners and automatic tripwire
	if has_version sys-apps/chpax
	then
		echo
		einfo "setting up conservative PaX flags for jar, javac and java"

		for paxkills in "java"
		do
			chpax -${CHPAX_CONSERVATIVE_FLAGS} /opt/${P}/bin/$paxkills
		done

		# /opt/sun-jdk-1.4.2.03/bin/java_vm
		chpax -${CHPAX_CONSERVATIVE_FLAGS} /opt/${P}/bin/java_vm

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
