# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/oracle-jre-bin/oracle-jre-bin-1.7.0.5.ebuild,v 1.2 2012/07/09 07:15:58 jdhore Exp $

EAPI="4"

inherit java-vm-2 eutils prefix versionator

UPDATE="$(get_version_component_range 4)"
MY_PV="$(get_version_component_range 2)u${UPDATE}"
S_PV="$(get_version_component_range 1-3)_0${UPDATE}"

X86_AT="jre-${MY_PV}-linux-i586.tar.gz"
AMD64_AT="jre-${MY_PV}-linux-x64.tar.gz"

# This URIs need updating when bumping!
JRE_URI="http://www.oracle.com/technetwork/java/javase/downloads/jre7-downloads-1637588.html"
JCE_URI="http://www.oracle.com/technetwork/java/javase/downloads/jce-7-download-432124.html"

JCE_DIR="UnlimitedJCEPolicy"
JCE_FILE="${JCE_DIR}JDK7.zip"

DESCRIPTION="Oracle's Java SE Runtime Environment"
HOMEPAGE="http://www.oracle.com/technetwork/java/javase/"
SRC_URI="
	x86? ( ${X86_AT} )
	amd64? ( ${AMD64_AT} )
	jce? ( ${JCE_FILE} )"

LICENSE="Oracle-BCLA-JavaSE"
SLOT="1.7"
KEYWORDS="~amd64 x86"

IUSE="X alsa jce nsplugin"
RESTRICT="fetch strip"

RDEPEND="
	X? (
		x11-libs/libXext
		x11-libs/libXi
		x11-libs/libXrender
		x11-libs/libXtst
		x11-libs/libX11
	)
	alsa? ( media-libs/alsa-lib )
	!prefix? ( sys-libs/glibc )"
DEPEND="
	jce? ( app-arch/unzip )"

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
		einfo "${JCE_URI}"
		einfo "and move it to ${DISTDIR}"
	fi
}

src_prepare() {
	if use jce; then
		mv "${WORKDIR}"/${JCE_DIR} lib/security/ || die
	fi
}

src_compile() {
	# This needs to be done before CDS - #215225
	java-vm_set-pax-markings "${S}"

	# see bug #207282
	einfo "Creating the Class Data Sharing archives"
	if use x86; then
		bin/java -client -Xshare:dump || die
	fi
	bin/java -server -Xshare:dump || die

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
	find "${D}" -type d -empty -exec rmdir -v {} + || die

	dodoc COPYRIGHT README

	if use jce; then
		dodir /opt/${P}/lib/security/strong-jce
		mv "${ED}"/opt/${P}/lib/security/US_export_policy.jar \
			"${ED}"/opt/${P}/lib/security/strong-jce || die
		mv "${ED}"/opt/${P}/lib/security/local_policy.jar \
			"${ED}"/opt/${P}/lib/security/strong-jce || die
		dosym /opt/${P}/lib/security/${JCE_DIR}/US_export_policy.jar \
			/opt/${P}/lib/security/US_export_policy.jar
		dosym /opt/${P}/lib/security/${JCE_DIR}/local_policy.jar \
			/opt/${P}/lib/security/local_policy.jar
	fi

	if use nsplugin; then
		install_mozilla_plugin /opt/${P}/lib/${arch}/libnpjp2.so
	fi

	# Install desktop file for the Java Control Panel.
	# Using ${PN}-${SLOT} to prevent file collision with jre and or other slots.
	# make_desktop_entry can't be used as ${P} would end up in filename.
	newicon lib/desktop/icons/hicolor/48x48/apps/sun-jcontrol.png \
		sun-jcontrol-${PN}-${SLOT}.png || die
	sed -e "s#Name=.*#Name=Java Control Panel for Oracle JRE ${SLOT}#" \
		-e "s#Exec=.*#Exec=/opt/${P}/bin/jcontrol#" \
		-e "s#Icon=.*#Icon=sun-jcontrol-${PN}-${SLOT}.png#" \
		lib/desktop/applications/sun_java.desktop > \
		"${T}"/jcontrol-${PN}-${SLOT}.desktop || die
	domenu "${T}"/jcontrol-${PN}-${SLOT}.desktop

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

QA_TEXTRELS_x86="
	opt/${P}/lib/i386/client/libjvm.so
	opt/${P}/lib/i386/server/libjvm.so"
QA_FLAGS_IGNORED+="
	/opt/${P}/bin/java
	/opt/${P}/bin/java_vm
	/opt/${P}/bin/javaws
	/opt/${P}/bin/keytool
	/opt/${P}/bin/orbd
	/opt/${P}/bin/pack200
	/opt/${P}/bin/policytool
	/opt/${P}/bin/rmid
	/opt/${P}/bin/rmiregistry
	/opt/${P}/bin/servertool
	/opt/${P}/bin/tnameserv
	/opt/${P}/bin/unpack200
	/opt/${P}/lib/jexec"
for java_system_arch in amd64 i386; do
	QA_FLAGS_IGNORED+="
		/opt/${P}/lib/${java_system_arch}/headless/libmawt.so
		/opt/${P}/lib/${java_system_arch}/jli/libjli.so
		/opt/${P}/lib/${java_system_arch}/libawt.so
		/opt/${P}/lib/${java_system_arch}/libdcpr.so
		/opt/${P}/lib/${java_system_arch}/libdeploy.so
		/opt/${P}/lib/${java_system_arch}/libdt_socket.so
		/opt/${P}/lib/${java_system_arch}/libfontmanager.so
		/opt/${P}/lib/${java_system_arch}/libhprof.so
		/opt/${P}/lib/${java_system_arch}/libinstrument.so
		/opt/${P}/lib/${java_system_arch}/libj2gss.so
		/opt/${P}/lib/${java_system_arch}/libj2pcsc.so
		/opt/${P}/lib/${java_system_arch}/libj2pkcs11.so
		/opt/${P}/lib/${java_system_arch}/libjaas_unix.so
		/opt/${P}/lib/${java_system_arch}/libjava_crw_demo.so
		/opt/${P}/lib/${java_system_arch}/libjavaplugin_jni.so
		/opt/${P}/lib/${java_system_arch}/libjava.so
		/opt/${P}/lib/${java_system_arch}/libjawt.so
		/opt/${P}/lib/${java_system_arch}/libJdbcOdbc.so
		/opt/${P}/lib/${java_system_arch}/libjdwp.so
		/opt/${P}/lib/${java_system_arch}/libjfr.so
		/opt/${P}/lib/${java_system_arch}/libjpeg.so
		/opt/${P}/lib/${java_system_arch}/libjsdt.so
		/opt/${P}/lib/${java_system_arch}/libjsig.so
		/opt/${P}/lib/${java_system_arch}/libjsoundalsa.so
		/opt/${P}/lib/${java_system_arch}/libjsound.so
		/opt/${P}/lib/${java_system_arch}/libkcms.so
		/opt/${P}/lib/${java_system_arch}/libmanagement.so
		/opt/${P}/lib/${java_system_arch}/libmlib_image.so
		/opt/${P}/lib/${java_system_arch}/libnet.so
		/opt/${P}/lib/${java_system_arch}/libnio.so
		/opt/${P}/lib/${java_system_arch}/libnpjp2.so
		/opt/${P}/lib/${java_system_arch}/libnpt.so
		/opt/${P}/lib/${java_system_arch}/librmi.so
		/opt/${P}/lib/${java_system_arch}/libsctp.so
		/opt/${P}/lib/${java_system_arch}/libsplashscreen.so
		/opt/${P}/lib/${java_system_arch}/libsunec.so
		/opt/${P}/lib/${java_system_arch}/libt2k.so
		/opt/${P}/lib/${java_system_arch}/libunpack.so
		/opt/${P}/lib/${java_system_arch}/libverify.so
		/opt/${P}/lib/${java_system_arch}/libzip.so
		/opt/${P}/lib/${java_system_arch}/server/libjvm.so
		/opt/${P}/lib/${java_system_arch}/xawt/libmawt.so"
done
