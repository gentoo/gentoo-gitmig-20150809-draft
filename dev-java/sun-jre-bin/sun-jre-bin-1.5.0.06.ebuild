# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/sun-jre-bin/sun-jre-bin-1.5.0.06.ebuild,v 1.8 2006/07/06 10:42:15 nelchael Exp $

inherit java eutils

MY_PVL=${PV%.*}_${PV##*.}
MY_PVA=${PV//./_}

amd64file="jre-${MY_PVA}-linux-amd64.bin"
x86file="jre-${MY_PVA}-linux-i586.bin"

if use x86; then
	At=${x86file}
elif use amd64; then
	At=${amd64file}
fi

S="${WORKDIR}/jre${MY_PVL}"
DESCRIPTION="Sun's J2SE Platform"
HOMEPAGE="http://java.sun.com/j2se/"
SRC_URI="x86? ( $x86file ) amd64? ( $amd64file )"
SLOT="1.5"
LICENSE="sun-bcla-java-vm"
KEYWORDS="-* amd64 x86"
RESTRICT="fetch stricter"
IUSE="X alsa browserplugin nsplugin mozilla"

DEPEND="sys-apps/sed"

RDEPEND="sys-libs/glibc
		alsa? ( media-libs/alsa-lib )
		X? ( || ( (
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


PACKED_JARS="lib/rt.jar lib/jsse.jar lib/charsets.jar lib/ext/localedata.jar lib/plugin.jar lib/javaws.jar lib/deploy.jar"

# this is needed for proper operating under a PaX kernel without activated grsecurity acl
CHPAX_CONSERVATIVE_FLAGS="pemsv"

FETCH_SDK="http://javashoplm.sun.com:80/ECom/docs/Welcome.jsp?StoreId=22&PartDetailId=jre-${MY_PVL}-oth-JPR&SiteId=JSC&TransactionId=noreg"


pkg_nofetch() {
	local archtext=""

	if use x86; then
		archtext="Linux"
	elif use amd64; then
		archtext="Linux AMD64"
	fi

	einfo "Please download ${At} from:"
	einfo ${FETCH_SDK}
	einfo "Select the ${archtext} self-extracting file"
	einfo "and move it to ${DISTDIR}"
}

src_unpack() {
	if [ ! -r ${DISTDIR}/${At} ]; then
		die "cannot read ${At}. Please check the permission and try again."
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
		sed -i 's#/tmp/unpack.log#/dev/null\x00\x00\x00\x00\x00\x00#g' $UNPACK_CMD
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
}

src_install() {

	if use amd64; then
		local dirs="bin lib man"
	else
		local dirs="bin lib man plugin javaws"
	fi


	dodir /opt/${P}

	for i in $dirs ; do
		cp -pPR $i ${D}/opt/${P}/ || die "failed to build"
	done

	dodoc COPYRIGHT README
	dohtml Welcome.html

	if use nsplugin ||       # global useflag for netscape-compat plugins
	   use browserplugin ||  # deprecated but honor for now
	   use mozilla; then     # wrong but used to honor it
		local plugin_dir="ns7-gcc29"
		if has_version '>=sys-devel/gcc-3' ; then
			plugin_dir="ns7"
		fi

		if use x86 ; then
			install_mozilla_plugin /opt/${P}/plugin/i386/$plugin_dir/libjavaplugin_oji.so
		else
			eerror "No plugin available for amd64 arch"
		fi
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
}

pkg_postinst() {
	# Create files used as storage for system preferences.
	PREFS_LOCATION=/opt/${P}/
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

	if ! use nsplugin && ( use browserplugin || use mozilla ); then
		echo
		ewarn "The 'browserplugin' and 'mozilla' useflags will not be honored in"
		ewarn "future jdk/jre ebuilds for plugin installation. Please"
		ewarn "update your USE to include 'nsplugin'."
	fi

	# Show info about netscape
	if has_version '>=www-client/netscape-navigator-4.79-r1' || has_version '>=www-client/netscape-communicator-4.79-r1' ; then
		echo
		einfo "If you want to install the plugin for Netscape 4.x, type"
		einfo
		einfo "   cd /usr/lib/nsbrowser/plugins/"
		einfo "   ln -sf /opt/${P}/plugin/i386/ns4/libjavaplugin.so"
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

		# /opt/$VM/bin/java_vm
		chpax -${CHPAX_CONSERVATIVE_FLAGS} /opt/${P}/bin/java_vm

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
	ewarn "Some parts of Sun's JRE require ${xwarn} virtual/lpr to be installed."
	ewarn "Be careful which Java libraries you attempt to use."
}
