# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-java/emul-linux-x86-java-1.6.0.23.ebuild,v 1.4 2011/02/13 19:02:14 hwoarang Exp $

inherit versionator pax-utils java-vm-2 eutils

UPDATE="$(get_version_component_range 4)"
UPDATE="${UPDATE#0}"
MY_PV="$(get_version_component_range 2)u${UPDATE}"

At="jdk-${MY_PV}-dlj-linux-i586.bin"
DESCRIPTION="Sun's Java SE Runtime Environment (32bit)"
HOMEPAGE="http://java.sun.com/javase/6/"
#SRC_URI="http://download.java.net/dlj/binaries/${At}"
SRC_URI="http://dlc.sun.com/dlj/binaries/${At}"

SLOT="1.6"
LICENSE="dlj-1.1"
KEYWORDS="-* amd64"
RESTRICT="strip"
IUSE="X alsa nsplugin"

JAVA_VM_NO_GENERATION1=true

RDEPEND="alsa? ( app-emulation/emul-linux-x86-soundlibs )
	X? ( app-emulation/emul-linux-x86-xlibs )"

JAVA_PROVIDE="jdbc-stdext jdbc-rowset"

QA_TEXTRELS_amd64="opt/${P}/lib/i386/motif21/libmawt.so
	opt/${P}/lib/i386/libdeploy.so
	opt/${P}/lib/i386/client/libjvm.so
	opt/${P}/lib/i386/server/libjvm.so"
QA_DT_HASH="opt/${P}/.*"

src_unpack() {
	mkdir bundled-jdk
	cd bundled-jdk
	sh "${DISTDIR}"/${At} --accept-license --unpack || die "Failed to unpack"

	cd ..
	bash "${FILESDIR}"/construct-${SLOT}.sh  bundled-jdk sun-jdk-${PV} ${P} || die "construct-${SLOT}.sh failed"
}

src_compile() {
	# Set PaX markings on all JDK/JRE executables to allow code-generation on
	# the heap by the JIT compiler. This has to be done before CDS - #215225
	pax-mark m $(list-paxables "${S}"/bin/*)

	# see bug #207282
	einfo "Creating the Class Data Sharing archives"
	"${S}"/bin/java -client -Xshare:dump || die
	"${S}"/bin/java -server -Xshare:dump || die
}

src_install() {
	local dirs="bin lib man javaws plugin"
	dodir /opt/${P}

	cp -pPR ${dirs} "${D}/opt/${P}/" || die "failed to copy"

	dodoc README THIRDPARTYLICENSEREADME.txt || die
	dohtml Welcome.html || die
	dodir /opt/${P}/share/

	if use nsplugin; then
		local plugin_dir="ns7-gcc29"
		if has_version '>=sys-devel/gcc-3' ; then
			plugin_dir="ns7"
		fi

		install_mozilla_plugin /opt/${P}/lib/i386/libnpjp2.so
		install_mozilla_plugin /opt/${P}/plugin/i386/$plugin_dir/libjavaplugin_oji.so old_oji
	fi

	# FIXME figure out how to handle the control pannel conflict with
	# sun-jdk-bin

	# install control panel for Gnome/KDE
#	sed -e "s/INSTALL_DIR\/JRE_NAME_VERSION/\/opt\/${P}\/jre/" \
#		-e "s/\(Name=Java\)/\1 Control Panel ${SLOT}/" \
#		${D}/opt/${P}/plugin/desktop/sun_java.desktop > \
#		${T}/sun_java-${SLOT}.desktop

#	domenu ${T}/sun_java-${SLOT}.desktop

	set_java_env
	java-vm_revdep-mask
}

pkg_postinst() {
	# Set as default VM if none exists
	java-vm-2_pkg_postinst

	elog
	elog "Two variants of the nsplugin are available via eselect java-nsplugin."
	elog "Note that starting with ${PN}-1.6.0.19 their naming and the default changed,"
	elog "users with the old plugin set are switched to the new default automatically."
	elog "The default ${VMHANDLE} is the new 'plugin2' which works in Firefox 3 (xulrunner-1.9)"
	elog "and newer, the ${VMHANDLE}-old_oji is the old plugin using the OJI API"
	elog "that was removed in Firefox 3.6 (xulrunner-1.9.2)."
	elog "For more info see https://jdk6.dev.java.net/plugin2/"
	elog

	if ! use X; then
		local xwarn="X11 libraries and/or"
	fi

	echo
	ewarn "Some parts of Sun's JDK require ${xwarn} virtual/lpr to be installed."
	ewarn "Be careful which Java libraries you attempt to use."
}
