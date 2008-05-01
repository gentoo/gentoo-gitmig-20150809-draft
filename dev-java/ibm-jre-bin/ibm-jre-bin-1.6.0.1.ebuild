# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ibm-jre-bin/ibm-jre-bin-1.6.0.1.ebuild,v 1.1 2008/05/01 23:09:06 caster Exp $

inherit java-vm-2 versionator eutils

JDK_RELEASE=$(get_version_component_range 2-3)
SERVICE_RELEASE=$(get_version_component_range 4)
SERVICE_RELEASE_LINK="${SERVICE_RELEASE}"
TGZ_PV="${JDK_RELEASE}-${SERVICE_RELEASE}.0"

JRE_DIST_PREFIX="ibm-java-jre-${TGZ_PV}-linux"

X86_JRE_DIST="${JRE_DIST_PREFIX}-i386.tgz"
AMD64_JRE_DIST="${JRE_DIST_PREFIX}-x86_64.tgz"
PPC_JRE_DIST="${JRE_DIST_PREFIX}-ppc.tgz"
PPC64_JRE_DIST="${JRE_DIST_PREFIX}-ppc64.tgz"

if use x86; then
	JRE_DIST=${X86_JRE_DIST}
	S="${WORKDIR}/ibm-java-i386-60"
	LINK_ARCH="intel"
elif use amd64; then
	JRE_DIST=${AMD64_JRE_DIST}
	S="${WORKDIR}/ibm-java-x86_64-60"
	LINK_ARCH="amd64"
elif use ppc; then
	JRE_DIST=${PPC_JRE_DIST}
	S="${WORKDIR}/ibm-java-ppc-60"
	LINK_ARCH="ipseries32"
elif use ppc64; then
	JRE_DIST=${PPC64_JRE_DIST}
	S="${WORKDIR}/ibm-java-ppc64-60"
	LINK_ARCH="ipseries64"
fi

DIRECT_DOWNLOAD="https://www14.software.ibm.com/webapp/iwm/web/preLogin.do?source=swg-sdk6&S_PKG=${LINK_ARCH}&S_TACT=105AGX05&S_CMP=JDK"

SLOT="1.6"
DESCRIPTION="IBM Java Runtime Environment ${SLOT}"
HOMEPAGE="http://www.ibm.com/developerworks/java/jdk/"
DOWNLOADPAGE="${HOMEPAGE}linux/download.html"
# bug #125178
ALT_DOWNLOADPAGE="${HOMEPAGE}linux/older_download.html"

SRC_URI="x86? ( ${X86_JRE_DIST} )
	amd64? ( ${AMD64_JRE_DIST} )
	ppc? ( ${PPC_JRE_DIST} )
	ppc64? ( ${PPC64_JRE_DIST} )"
LICENSE="IBM-J1.6"
KEYWORDS="-* ~amd64 ~ppc ~ppc64 ~x86"
RESTRICT="fetch"
IUSE="X alsa nsplugin odbc"

RDEPEND="
		X? (
			x11-libs/libXext
			x11-libs/libXft
			x11-libs/libXi
			x11-libs/libXp
			x11-libs/libXtst
			x11-libs/libX11
			amd64? ( x11-libs/libXt )
		)
		alsa? ( media-libs/alsa-lib )
		odbc? ( dev-db/unixODBC )"
DEPEND=""

QA_TEXTRELS_x86="opt/${P}/lib/i386/libj9jvmti24.so
opt/${P}/lib/i386/libj9vm24.so
opt/${P}/lib/i386/libjclscar_24.so
opt/${P}/lib/i386/motif21/libmawt.so
opt/${P}/lib/i386/libj9thr24.so
opt/${P}/lib/i386/libj9jit24.so
opt/${P}/lib/i386/libj9dbg24.so
opt/${P}/lib/i386/libj9gc24.so"

QA_EXECSTACK_x86="opt/${P}/bin/classic/libjvm.so
opt/${P}/lib/i386/j9vm/libjvm.so
opt/${P}/lib/i386/libj9jvmti24.so
opt/${P}/lib/i386/libj9hookable24.so
opt/${P}/lib/i386/libj9vm24.so
opt/${P}/lib/i386/libjclscar_24.so
opt/${P}/lib/i386/libj9thr24.so
opt/${P}/lib/i386/libj9dmp24.so
opt/${P}/lib/i386/libj9prt24.so
opt/${P}/lib/i386/libj9jit24.so
opt/${P}/lib/i386/libiverel24.so
opt/${P}/lib/i386/libj9trc24.so
opt/${P}/lib/i386/libj9dbg24.so
opt/${P}/lib/i386/libj9shr24.so
opt/${P}/lib/i386/libj9gc24.so
opt/${P}/lib/i386/libj9bcv24.so
opt/${P}/lib/i386/classic/libjvm.so"

QA_EXECSTACK_amd64="opt/${P}/lib/amd64/default/libjvm.so
opt/${P}/lib/amd64/default/libj9jvmti24.so
opt/${P}/lib/amd64/default/libj9hookable24.so
opt/${P}/lib/amd64/default/libj9vm24.so
opt/${P}/lib/amd64/default/libjclscar_24.so
opt/${P}/lib/amd64/default/libj9jpi24.so
opt/${P}/lib/amd64/default/libj9thr24.so
opt/${P}/lib/amd64/default/libj9dmp24.so
opt/${P}/lib/amd64/default/libj9prt24.so
opt/${P}/lib/amd64/default/libj9jit24.so
opt/${P}/lib/amd64/default/libiverel24.so
opt/${P}/lib/amd64/default/libj9trc24.so
opt/${P}/lib/amd64/default/libj9dbg24.so
opt/${P}/lib/amd64/default/libj9shr24.so
opt/${P}/lib/amd64/default/libj9gc24.so
opt/${P}/lib/amd64/default/libj9bcv24.so
opt/${P}/lib/amd64/compressedrefs/libjvm.so
opt/${P}/lib/amd64/compressedrefs/libj9jvmti24.so
opt/${P}/lib/amd64/compressedrefs/libj9hookable24.so
opt/${P}/lib/amd64/compressedrefs/libj9vm24.so
opt/${P}/lib/amd64/compressedrefs/libjclscar_24.so
opt/${P}/lib/amd64/compressedrefs/libj9jpi24.so
opt/${P}/lib/amd64/compressedrefs/libj9thr24.so
opt/${P}/lib/amd64/compressedrefs/libj9dmp24.so
opt/${P}/lib/amd64/compressedrefs/libj9prt24.so
opt/${P}/lib/amd64/compressedrefs/libj9jit24.so
opt/${P}/lib/amd64/compressedrefs/libiverel24.so
opt/${P}/lib/amd64/compressedrefs/libj9trc24.so
opt/${P}/lib/amd64/compressedrefs/libj9dbg24.so
opt/${P}/lib/amd64/compressedrefs/libj9shr24.so
opt/${P}/lib/amd64/compressedrefs/libj9gc24.so
opt/${P}/lib/amd64/compressedrefs/libj9bcv24.so"

pkg_nofetch() {
	einfo "Due to license restrictions, we cannot redistribute or fetch the distfiles"
	einfo "Please visit: ${DOWNLOADPAGE}"

	einfo "Under Java SE 6, download GA for your arch:" #SR${SERVICE_RELEASE}
	einfo "${JRE_DIST}"

	einfo "You can use direct link to your arch download page:"
	einfo "${DIRECT_DOWNLOAD}"
	einfo "Place the file(s) in: ${DISTDIR}"
	einfo "Then restart emerge: 'emerge --resume'"

	einfo "Note: if GA is not available at ${DOWNLOADPAGE}"
	einfo "it may have been moved to ${ALT_DOWNLOADPAGE}. Lately that page"
	einfo "isn't updated, but the files should still available through the"
	einfo "direct link to arch download page. If it doesn't work, file a bug."
}

src_compile() { :; }

src_install() {
	# Copy all the files to the designated directory
	dodir /opt/${P}
	cp -pR "${S}"/jre/* "${D}/opt/${P}/"

	if use x86 || use ppc; then
		if use nsplugin; then
			local plugin="/opt/${P}/plugin/$(get_system_arch)/ns7/libjavaplugin_oji.so"
			install_mozilla_plugin "${plugin}"
		fi
	fi

	local desktop_in="${D}/opt/${P}/plugin/desktop/sun_java.desktop"
	if [[ -f "${desktop_in}" ]]; then
		local desktop_out="${T}/ibm_jre-${SLOT}.desktop"
		# install control panel for Gnome/KDE
		# The jdk also installs these so make sure that they do not have the same
		# Name
		sed -e "s/\(Name=\)Java/\1 Java Control Panel for IBM JRE ${SLOT}/" \
			-e "s#Exec=.*#Exec=/opt/${P}/jre/bin/jcontrol#" \
			-e "s#Icon=.*#Icon=/opt/${P}/jre/plugin/desktop/sun_java.png#" \
			"${desktop_in}" > \
			"${desktop_out}" || die

		domenu "${desktop_out}" || die
	fi

	dohtml -a html,htm,HTML -r docs || die
	dodoc "${S}"/{copyright,notices.txt,readmefirst.lnx.txt} || die

	set_java_env
	java-vm_revdep-mask
}
