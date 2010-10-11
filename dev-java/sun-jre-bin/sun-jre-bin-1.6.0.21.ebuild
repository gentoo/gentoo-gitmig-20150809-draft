# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/sun-jre-bin/sun-jre-bin-1.6.0.21.ebuild,v 1.4 2010/10/11 14:46:30 hwoarang Exp $

inherit versionator pax-utils eutils java-vm-2

UPDATE="$(get_version_component_range 4)"
UPDATE="${UPDATE#0}"
MY_PV="$(get_version_component_range 2)u${UPDATE}"

SUFFIX=".bin"
X86_AT="jdk-${MY_PV}-dlj-linux-i586${SUFFIX}"
AMD64_AT="jdk-${MY_PV}-dlj-linux-amd64${SUFFIX}"

DESCRIPTION="Sun's Java SE Runtime Environment"
HOMEPAGE="http://java.sun.com/javase/6/"
URL_BASE="http://download.java.net/dlj/binaries"
SRC_URI="x86? ( ${URL_BASE}/${X86_AT} )
		amd64? ( ${URL_BASE}/${AMD64_AT} )"
SLOT="1.6"
LICENSE="dlj-1.1"
KEYWORDS="-* amd64 x86"
RESTRICT="strip"
IUSE="X alsa jce nsplugin odbc"

DEPEND="jce? ( =dev-java/sun-jce-bin-1.6.0* )"
RDEPEND="${DEPEND}
	sys-libs/glibc
	alsa? ( media-libs/alsa-lib )
	X? (
		x11-libs/libXext
		x11-libs/libXi
		x11-libs/libXp
		x11-libs/libXtst
		amd64? ( x11-libs/libXt )
		x11-libs/libX11
	)
	odbc? ( dev-db/unixODBC )"

JAVA_PROVIDE="jdbc-stdext jdbc-rowset"

QA_TEXTRELS_x86="opt/${P}/lib/i386/client/libjvm.so
	opt/${P}/lib/i386/motif21/libmawt.so
	opt/${P}/lib/i386/libdeploy.so
	opt/${P}/lib/i386/server/libjvm.so"

src_unpack() {
	mkdir bundled-jdk
	cd bundled-jdk
	sh "${DISTDIR}"/${A} --accept-license --unpack || die "Failed to unpack"

	cd ..
	bash "${FILESDIR}/construct-1.6.sh"  bundled-jdk sun-jdk-${PV} ${P} || die "construct.sh failed"
}

src_compile() {
	# Set PaX markings on all JDK/JRE executables to allow code-generation on
	# the heap by the JIT compiler. This has to be done before CDS - #215225
	pax-mark m $(list-paxables "${S}"/bin/*)

	# see bug #207282
	if use x86; then
		einfo "Creating the Class Data Sharing archives"
		"${S}"/bin/java -client -Xshare:dump || die
		"${S}"/bin/java -server -Xshare:dump || die
	fi
}

src_install() {
	local dirs="bin lib man"

	# only X86 has the plugin and javaws
	use x86 && dirs="${dirs} javaws plugin"
	dodir /opt/${P}

	cp -pPR $dirs "${D}/opt/${P}/" || die "failed to copy"

	dodoc README THIRDPARTYLICENSEREADME.txt || die
	dohtml Welcome.html || die
	dodir /opt/${P}/share/

	if use jce; then
		cd "${D}/opt/${P}/lib/security"
		dodir /opt/${P}/lib/security/strong-jce
		mv "${D}"/opt/${P}/lib/security/US_export_policy.jar \
			"${D}"/opt/${P}/lib/security/strong-jce || die
		mv "${D}"/opt/${P}/lib/security/local_policy.jar \
			"${D}"/opt/${P}/lib/security/strong-jce || die
		dosym /opt/sun-jce-bin-1.6.0/jre/lib/security/unlimited-jce/US_export_policy.jar /opt/${P}/lib/security/
		dosym /opt/sun-jce-bin-1.6.0/jre/lib/security/unlimited-jce/local_policy.jar /opt/${P}/lib/security/
	fi

	if use nsplugin; then
		local plugin_dir="ns7-gcc29"
		if has_version '>=sys-devel/gcc-3' ; then
			plugin_dir="ns7"
		fi

		if use x86 ; then
			install_mozilla_plugin /opt/${P}/lib/i386/libnpjp2.so
			install_mozilla_plugin /opt/${P}/plugin/i386/$plugin_dir/libjavaplugin_oji.so old_oji
		else
			install_mozilla_plugin /opt/${P}/lib/amd64/libnpjp2.so
		fi
	fi

	# install control panel for Gnome/KDE
	if [[ -e "${D}/opt/${P}/plugin/desktop/sun_java.desktop" ]]; then
		sed -e "s/\(Name=Java\)/\1 Control Panel for Sun JRE ${SLOT}/" \
			-e "s#Exec=.*#Exec=/opt/${P}/bin/ControlPanel#" \
			-e "s#Icon=.*#Icon=/opt/${P}/plugin/desktop/sun_java.png#" \
			"${D}/opt/${P}/plugin/desktop/sun_java.desktop" > \
			"${T}/sun_jre-${SLOT}.desktop" || die
		domenu "${T}/sun_jre-${SLOT}.desktop" || die
	fi

	# bug #56444
	insinto /opt/${P}/lib/
	newins "${FILESDIR}"/fontconfig.Gentoo.properties fontconfig.properties

	set_java_env
	java-vm_revdep-mask
}

pkg_postinst() {
	# Set as default VM if none exists
	java-vm-2_pkg_postinst

	if use x86 && use nsplugin; then
		elog
		elog "Two variants of the nsplugin are available via eselect java-nsplugin:"
		elog "Note that starting with ${PN}-1.6.0.18-r1 their naming and the default changed,"
		elog "users with the old plugin set are switched to the new default automatically."
		elog "The default ${VMHANDLE} is the new 'plugin2' which works in Firefox 3 (xulrunner-1.9)"
		elog "and newer, the ${VMHANDLE}-old_oji is the old plugin using the OJI API"
		elog "that was removed in Firefox 3.6 (xulrunner-1.9.2)."
		elog "For more info see https://jdk6.dev.java.net/plugin2/"
		elog
	fi

	if use amd64 && use nsplugin; then
		elog
		elog "The amd64 version ships the new 'plugin2' browser plugin which works"
		elog "in Firefox 3+ and other recent browser versions."
		elog "For more info see https://jdk6.dev.java.net/plugin2/"
		elog
	fi
}
