# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/diablo-jdk/diablo-jdk-1.6.0.07.02.ebuild,v 1.3 2011/05/21 04:29:26 ssuominen Exp $

inherit java-vm-2 eutils versionator

DESCRIPTION="Java Development Kit"
HOMEPAGE="http://www.FreeBSDFoundation.org/downloads/java.shtml"
MY_PV=$(replace_version_separator 3 '_')
MY_PVL=$(get_version_component_range 1-3)

javafile="diablo-caffe-freebsd7-i386-$(replace_version_separator 4 '-b' ${MY_PV}).tar.bz2"

SRC_URI="$javafile"

LICENSE="sun-bcla-java-vm"
SLOT="1.6"
KEYWORDS="-* ~x86-fbsd"
RESTRICT="fetch"
IUSE="X examples nsplugin jce"

QA_TEXTRELS_x86="opt/${P}/jre/lib/i386/motif21/libmawt.so opt/${P}/jre/lib/i386/server/libjvm.so opt/${P}/jre/lib/i386/client/libjvm.so"

DEPEND="jce? ( =dev-java/sun-jce-bin-1.6.0* )"
RDEPEND="X? ( x11-libs/libICE
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
		>=sys-freebsd/freebsd-lib-7
		${DEPEND}"

JAVA_PROVIDE="jdbc-stdext jdbc-rowset"
S="${WORKDIR}/diablo-jdk$(get_version_component_range 1-4 ${MY_PV})"

pkg_nofetch() {
	einfo "Please download ${javafile} from:"
	einfo "${HOMEPAGE}"
	einfo "and move it to ${DISTDIR}"
}

src_install() {
	local dirs="bin include jre lib man"

	dodir /opt/${P}

	for i in $dirs ; do
		cp -pPR $i "${D}"/opt/${P}/ || die "failed to build"
	done

	dodoc COPYRIGHT README.html
	dohtml README.html

	dodir /opt/${P}/share/

	cp -pPR src.zip "${D}"/opt/${P}/share/

	if use examples; then
		cp -pPR demo "${D}"/opt/${P}/share/
		cp -pRR sample "${D}"/opt/${P}/share/
	fi

	if use jce ; then
		cd "${D}"/opt/${P}/jre/lib/security
		dodir /opt/${P}/jre/lib/security/strong-jce
		mv "${D}"/opt/${P}/jre/lib/security/US_export_policy.jar "${D}"/opt/${P}/jre/lib/security/strong-jce
		mv "${D}"/opt/${P}/jre/lib/security/local_policy.jar "${D}"/opt/${P}/jre/lib/security/strong-jce
		dosym /opt/sun-jce-bin-1.6.0/jre/lib/security/unlimited-jce/US_export_policy.jar /opt/${P}/jre/lib/security/
		dosym /opt/sun-jce-bin-1.6.0/jre/lib/security/unlimited-jce/local_policy.jar /opt/${P}/jre/lib/security/
	fi

	if use nsplugin; then
		install_mozilla_plugin /opt/${P}/jre/plugin/i386/ns7/libjavaplugin_oji.so
	fi

	# Change libz.so.4 to libz.so.1
	scanelf -qR -N libz.so.4 -F "#N" "${D}"/opt/${P}/ | \
		while read i; do
		if [[ $(strings "$i" | fgrep -c libz.so.4) -ne 1 ]]; then
			export SANITY_CHECK_LIBZ_FAILED=1
			break
		fi
		sed -i -e 's/libz\.so\.4/libz.so.1/g' "$i"
	done
	[[ "$SANITY_CHECK_LIBZ_FAILED" = "1" ]] && die "failed to change libz.so.4 to libz.so.1"

	# create dir for system preferences
	dodir /opt/${P}/jre/.systemPrefs
	# Create files used as storage for system preferences.
	touch "${D}"/opt/${P}/jre/.systemPrefs/.system.lock
	chmod 644 "${D}"/opt/${P}/jre/.systemPrefs/.system.lock
	touch "${D}"/opt/${P}/jre/.systemPrefs/.systemRootModFile
	chmod 644 "${D}"/opt/${P}/jre/.systemPrefs/.systemRootModFile

	# install control panel for Gnome/KDE
	sed -e "s/INSTALL_DIR\/JRE_NAME_VERSION/\/opt\/${P}\/jre/" \
		-e "s/\(Name=Java\)/\1 Control Panel ${SLOT}/" \
		"${D}"/opt/${P}/jre/plugin/desktop/sun_java.desktop > \
		"${T}"/sun_java-${SLOT}.desktop

	domenu "${T}"/sun_java-${SLOT}.desktop

	set_java_env
}

pkg_postinst() {
	# Set as default VM if none exists
	java-vm-2_pkg_postinst

	if ! use X; then
		local xwarn="X11 libraries and/or"
	fi

	echo
	ewarn "Some parts of Sun's JRE require ${xwarn} net-print/cups or net-print/lprng to be installed."
	ewarn "Be careful which Java libraries you attempt to use."

	echo
	elog "Be careful: ${P}'s Java compiler uses"
	elog "'-source 1.5' as default. Some keywords such as 'enum'"
	elog "are not valid identifiers any more in that mode,"
	elog "which can cause incompatibility with certain sources."
}
