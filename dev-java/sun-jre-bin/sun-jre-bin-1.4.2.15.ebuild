# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/sun-jre-bin/sun-jre-bin-1.4.2.15.ebuild,v 1.2 2007/07/02 18:57:09 opfer Exp $

inherit eutils pax-utils java-vm-2

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
# pre stripped
RESTRICT="fetch strip"
IUSE="X alsa nsplugin"

DEPEND=""

RDEPEND="alsa? ( media-libs/alsa-lib )
	X? (
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXi
		x11-libs/libXp
		x11-libs/libXt
		x11-libs/libXtst
	)"

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
		local PACKED_JARS="lib/rt.jar lib/jsse.jar lib/charsets.jar \
			lib/ext/localedata.jar lib/plugin.jar javaws/javaws.jar"
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

	cp -pPR ${dirs} "${D}/opt/${P}/"

	pax-mark srpm $(list-paxables "${D}"/opt/${P}/bin/*)

	dodoc CHANGES COPYRIGHT README LICENSE THIRDPARTYLICENSEREADME.txt || die
	dohtml Welcome.html ControlPanel.html || die

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

	if ! use X; then
		echo
		ewarn "Some parts of Sun's JDK require virtual/x11 to be installed."
		ewarn "Be careful which Java libraries you attempt to use."
	fi
}
