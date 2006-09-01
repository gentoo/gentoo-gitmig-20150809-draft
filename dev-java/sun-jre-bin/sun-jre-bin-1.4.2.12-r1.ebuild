# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/sun-jre-bin/sun-jre-bin-1.4.2.12-r1.ebuild,v 1.2 2006/09/01 03:09:34 nichoj Exp $

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
KEYWORDS="-* ~x86"
RESTRICT="fetch stricter"
IUSE="X alsa nsplugin"

DEPEND="sys-apps/sed"

RDEPEND="sys-libs/glibc
	alsa? ( media-libs/alsa-lib )
	X? ( || (	(
				x11-libs/libX11
				x11-libs/libXext
				x11-libs/libXi
				x11-libs/libXp
				x11-libs/libXt
				x11-libs/libXtst
			)

			virtual/x11
		)
	)"


PACKED_JARS="lib/rt.jar lib/jsse.jar lib/charsets.jar
lib/ext/localedata.jar lib/plugin.jar javaws/javaws.jar"

# this is needed for proper operating under a PaX kernel without activated grsecurity acl
CHPAX_CONSERVATIVE_FLAGS="pemsv"

DOWNLOAD_URL="http://javashoplm.sun.com/ECom/docs/Welcome.jsp?StoreId=22&PartDetailId=j2re-${MY_PV}-oth-JPR&SiteId=JSC&TransactionId=noreg"

pkg_nofetch() {
	einfo "Please download ${At} from:"
	einfo ${DOWNLOAD_URL}
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

	# create dir for system preferences
	dodir /opt/${P}/.systemPrefs

	# install control panel for Gnome/KDE
	sed -e "s/INSTALL_DIR\/JRE_NAME_VERSION/\/opt\/${P}/" \
		-e "s/\(Name=Java\)/\1 Control Panel/" \
		${D}/opt/${P}/plugin/desktop/sun_java.desktop > \
		${T}/sun_java-jre.desktop
	domenu ${T}/sun_java-jre.desktop

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

	java-vm-2_pkg_postinst

	# Show info about netscape
	if has_version '>=www-client/netscape-navigator-4.79-r1' || has_version '>=www-client/netscape-communicator-4.79-r1' ; then
		echo
		einfo "If you want to install the plugin for Netscape 4.x, type"
		einfo
		einfo "   cd /usr/lib/nsbrowser/plugins/"
		einfo "   ln -sf /opt/${P}/jre/plugin/i386/ns4/libjavaplugin.so"
	fi

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
