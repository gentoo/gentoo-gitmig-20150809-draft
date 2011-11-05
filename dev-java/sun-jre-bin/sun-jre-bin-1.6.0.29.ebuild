# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/sun-jre-bin/sun-jre-bin-1.6.0.29.ebuild,v 1.5 2011/11/05 23:37:42 caster Exp $

EAPI="4"

inherit java-vm-2 eutils pax-utils prefix versionator

MY_PV="$(get_version_component_range 2)u$(get_version_component_range 4)"
S_PV="$(replace_version_separator 3 '_')"

X86_AT="jre-${MY_PV}-linux-i586.bin"
AMD64_AT="jre-${MY_PV}-linux-x64.bin"

# check the URIs when bumping, no idea about their stability yet
JRE_URI="http://www.oracle.com/technetwork/java/javase/downloads/jre-${MY_PV}-download-513650.html"

DESCRIPTION="Oracle's Java SE Runtime Environment"
HOMEPAGE="http://www.oracle.com/technetwork/java/javase/"
SRC_URI="x86? ( ${X86_AT} )
	amd64? ( ${AMD64_AT} )"

LICENSE="Oracle-BCLA-JavaSE"
KEYWORDS="amd64 x86"
SLOT="1.6"
IUSE="X alsa jce nsplugin"

RESTRICT="fetch strip"
QA_TEXTRELS_x86="
	opt/${P}/lib/i386/client/libjvm.so
	opt/${P}/lib/i386/motif21/libmawt.so
	opt/${P}/lib/i386/server/libjvm.so"

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
DEPEND="jce? ( dev-java/sun-jce-bin:1.6 )"

S="${WORKDIR}/jre${S_PV}"

pkg_nofetch() {
	if use x86; then
		AT=${X86_AT}
	elif use amd64; then
		AT=${AMD64_AT}
	fi

	einfo "Due to Oracle no longer providing the distro-friendly DLJ bundles, the package has become fetch restricted again."
	einfo "Alternatives are switching to dev-java/icedtea-bin or the source-based dev-java/icedtea:6"

	einfo "Please download ${AT} from:"
	einfo "${JRE_URI}"
	einfo "and move it to ${DISTDIR}"
}

src_unpack() {
	sh "${DISTDIR}"/${A} -noregister || die "Failed to unpack"
}

src_compile() {
	# Set PaX markings on all JDK/JRE executables to allow code-generation on
	# the heap by the JIT compiler. This needs to be done before CDS - #215225
	pax-mark m $(list-paxables "${S}"/bin/*)

	# see bug #207282
	einfo "Creating the Class Data Sharing archives"
	if use x86; then
		"${S}"/bin/java -client -Xshare:dump || die
	fi
	"${S}"/bin/java -server -Xshare:dump || die
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
		dosym /opt/sun-jce-bin-1.6.0/lib/security/unlimited-jce/US_export_policy.jar \
			/opt/${P}/lib/security/US_export_policy.jar
		dosym /opt/sun-jce-bin-1.6.0/lib/security/unlimited-jce/local_policy.jar \
			/opt/${P}/lib/security/local_policy.jar
	fi

	if use nsplugin; then
		install_mozilla_plugin /opt/${P}/lib/${arch}/libnpjp2.so
	fi

	# Install desktop file for the Java Control Panel. Using VMHANDLE as file
	# name to prevent file collision with jdk and or other slots.
	[[ -f "${ED}"/opt/${P}/lib/desktop/applications/sun_java.desktop ]] || die
	sed -e "s/\(Name=\)Java/\1 Java Control Panel for Oracle JRE ${SLOT} (sun-jre-bin)/" \
		-e "s#Exec=.*#Exec=/opt/${P}/bin/jcontrol#" \
		-e "s#Icon=.*#Icon=/opt/${P}/lib/desktop/icons/hicolor/48x48/apps/sun-jcontrol.png#" \
		"${ED}"/opt/${P}/lib/desktop/applications/sun_java.desktop > \
		"${T}"/${VMHANDLE}.desktop

	domenu "${T}"/${VMHANDLE}.desktop

	# bug #56444
	cp "${FILESDIR}"/fontconfig.Gentoo.properties-r1 "${T}"/fontconfig.properties || die
	eprefixify "${T}"/fontconfig.properties
	insinto /opt/${P}/lib/
	doins "${T}"/fontconfig.properties

	set_java_env "${FILESDIR}/${VMHANDLE}.env-r1"
	java-vm_revdep-mask
}
