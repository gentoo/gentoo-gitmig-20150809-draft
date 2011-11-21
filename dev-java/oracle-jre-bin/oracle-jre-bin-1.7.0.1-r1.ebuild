# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/oracle-jre-bin/oracle-jre-bin-1.7.0.1-r1.ebuild,v 1.2 2011/11/21 10:45:21 sera Exp $

EAPI="4"

inherit java-vm-2 eutils prefix versionator

UPDATE="$(get_version_component_range 4)"
UPDATE="${UPDATE#0}"
MY_PV="$(get_version_component_range 2)u${UPDATE}"
S_PV="$(get_version_component_range 1-3)_0${UPDATE}"

X86_AT="jre-${MY_PV}-linux-i586.tar.gz"
AMD64_AT="jre-${MY_PV}-linux-x64.tar.gz"

# check the URIs when bumping, no idea about their stability yet
JRE_URI="http://www.oracle.com/technetwork/java/javase/downloads/jre-7u1-download-513652.html"
JCE_URI="http://www.oracle.com/technetwork/java/javase/downloads/jce-7-download-432124.html"

JCE_DIR="UnlimitedJCEPolicy"
JCE_FILE="${JCE_DIR}JDK7.zip"

DESCRIPTION="Oracle's Java SE Runtime Environment"
HOMEPAGE="http://www.oracle.com/technetwork/java/javase/"
SRC_URI="x86? ( ${X86_AT} )
	amd64? ( ${AMD64_AT} )
	jce? ( ${JCE_FILE} )"
SLOT="1.7"
LICENSE="Oracle-BCLA-JavaSE"
KEYWORDS="~amd64 ~x86"
RESTRICT="fetch strip"
IUSE="X alsa jce nsplugin"

QA_TEXTRELS_x86="
	opt/${P}/lib/i386/client/libjvm.so
	opt/${P}/lib/i386/server/libjvm.so"

DEPEND="jce? ( app-arch/unzip )"
RDEPEND="${DEPEND}
	!prefix? ( sys-libs/glibc )
	alsa? ( media-libs/alsa-lib )
	X? (
		x11-libs/libXext
		x11-libs/libXi
		x11-libs/libXrender
		x11-libs/libXtst
		x11-libs/libX11
	)"

S="${WORKDIR}/jre${S_PV}"

pkg_nofetch() {
	if use x86; then
		AT=${X86_AT}
	elif use amd64; then
		AT=${AMD64_AT}
	fi

	einfo "Please download ${AT} from:"
	einfo "${JRE_URI}"
	einfo "and move it to ${DISTDIR}"

	if use jce; then
		einfo "Also download ${JCE_FILE} from:"
		einfo ${JCE_URI}
		einfo "and move it to ${DISTDIR}"
	fi
}

src_prepare() {
	if use jce; then
		mv "${WORKDIR}"/${JCE_DIR} "${S}"/lib/security/ || die
	fi
}

src_compile() {
	# This needs to be done before CDS - #215225
	java-vm_set-pax-markings "${S}"

	# see bug #207282
	einfo "Creating the Class Data Sharing archives"
	if use x86; then
		"${S}"/bin/java -client -Xshare:dump || die
	fi
	"${S}"/bin/java -server -Xshare:dump || die

	# Create files used as storage for system preferences.
	mkdir .systemPrefs || die
	touch .systemPrefs/.system.lock || die
	touch .systemPrefs/.systemRootModFile || die
}

src_install() {
	# We should not need the ancient plugin for Firefox 2 anymore, plus it has
	# writable executable segments
	if use x86; then
		rm -vf lib/i386/libjavaplugin_oji.so \
			lib/i386/libjavaplugin_nscp*.so
		rm -vrf plugin/i386
	fi
	# Without nsplugin flag, also remove the new plugin
	local arch=${ARCH};
	use x86 && arch=i386;
	if ! use nsplugin; then
		rm -vf lib/${arch}/libnpjp2.so \
			lib/${arch}/libjavaplugin_jni.so
	fi

	dodir /opt/${P}
	cp -pPR bin lib man "${ED}"/opt/${P} || die

	# Remove empty dirs we might have copied
	rmdir -v $(find "${D}" -type d -empty) || die

	dodoc COPYRIGHT README

	if use jce; then
		dodir /opt/${P}/lib/security/strong-jce
		mv "${ED}"/opt/${P}/lib/security/US_export_policy.jar \
			"${ED}"/opt/${P}/lib/security/strong-jce || die
		mv "${ED}"/opt/${P}/lib/security/local_policy.jar \
			"${ED}"/opt/${P}/lib/security/strong-jce || die
		dosym /opt/${P}/lib/security/${JCE_DIR}/US_export_policy.jar \
			/opt/${P}/lib/security/
		dosym /opt/${P}/lib/security/${JCE_DIR}/local_policy.jar \
			/opt/${P}/lib/security/
	fi

	if use nsplugin; then
		install_mozilla_plugin /opt/${P}/lib/${arch}/libnpjp2.so
	fi

	# Install desktop file for the Java Control Panel. Using VMHANDLE as file
	# name to prevent file collision with jre and or other slots.
	[[ -f "${ED}"/opt/${P}/lib/desktop/applications/sun_java.desktop ]] || die
	sed -e "s/\(Name=\)Java/\1 Java Control Panel for Oracle JRE ${SLOT}/" \
		-e "s#Exec=.*#Exec=/opt/${P}/bin/jcontrol#" \
		-e "s#Icon=.*#Icon=/opt/${P}/lib/desktop/icons/hicolor/48x48/apps/sun-jcontrol.png#" \
		"${ED}"/opt/${P}/lib/desktop/applications/sun_java.desktop > \
		"${T}"/${VMHANDLE}.desktop

	domenu "${T}"/${VMHANDLE}.desktop

	# bug #56444
	cp "${FILESDIR}"/fontconfig.Gentoo.properties "${T}"/fontconfig.properties || die
	eprefixify "${T}"/fontconfig.properties
	insinto /opt/${P}/lib/
	doins "${T}"/fontconfig.properties

	# bug #388127
	dodir /etc/sandbox.d
	echo 'SANDBOX_PREDICT="/dev/random:/proc/self/coredump_filter"' > "${D}/etc/sandbox.d/20${VMHANDLE}"

	set_java_env
	java-vm_revdep-mask
}
