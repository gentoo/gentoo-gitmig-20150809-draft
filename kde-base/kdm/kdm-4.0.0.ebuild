# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdm/kdm-4.0.0.ebuild,v 1.2 2008/01/18 03:26:13 ingmar Exp $

EAPI="1"

KMNAME=kdebase-workspace
inherit kde4-meta

DESCRIPTION="KDE login manager, similar to xdm and gdm"
KEYWORDS="~amd64 ~x86"
IUSE="debug elibc_glibc htmlhandbook kerberos pam"

DEPEND="
	x11-libs/libXau
	x11-libs/libXdmcp
	x11-libs/libXtst
	kerberos? ( virtual/krb5 )
	pam? ( >=kde-base/kcheckpass-${PV}:${SLOT}
		sys-libs/pam )"
RDEPEND="${DEPEND}
	>=kde-base/kdepasswd-${PV}:${SLOT}
	>=x11-apps/xinit-1.0.5-r2
	x11-apps/xmessage"

KMEXTRACTONLY="
	kcontrol/background/
	kcontrol/kdm/
	kdm/frontend/sessions"
# kde-base/kdebase-startkde installs the xession entry, so only extract here
KMEXTRA="libs/kdm/"

# Disable creating dirs in the live file system.
PATCHES="
${FILESDIR}/${P}-genkdmconf.patch
${FILESDIR}/kdebase-${PV}-pam-optional.patch"

src_compile() {
	mycmakeargs="${mycmakeargs}
		$(use kerberos && echo "-DKDE4_KRB5AUTH=ON" || echo "-DKDE4_KRB5AUTH=OFF")
		$(cmake-utils_use_with pam PAM)"
	kde4-meta_src_compile
}

src_install() {
	# This needs to be removed because it simply doesn't work and either
	# causes a sandbox violation or just does nothing.
	sed -i -e "/exec_program/d" "${S}"/kdm/kfrontend/CMakeLists.txt

	kde4-meta_src_install

	dodir "${PREFIX}"/share/config/kdm
	fperms 755 "${PREFIX}"/share/config/kdm
	# We need to generate the kdm configuration here because it won't work
	# in any other way.
	"${WORKDIR}"/kdm_build/kdm/kfrontend/genkdmconf --in "${D}/${PREFIX}/share/config/kdm" \
		--no-in-notice --face-src "${S}"/kdm/kfrontend/pics --no-old --no-backup

	# Customize the kdmrc configuration
	sed -i -e "s:^.*SessionsDirs=.*$:#&\nSessionsDirs=/usr/share/xsessions:" \
		"${D}"/${PREFIX}/share/config/kdm/kdmrc \
		|| die "Failed to set SessionsDirs correctly."
}

pkg_postinst() {
	# Set the default kdm face icon if it's not already set by the system admin
	# because this is user-overrideable in that way, it's not in src_install
	if [[ ! -e "${ROOT}${KDEDIR}/share/apps/kdm/faces/.default.face.icon" ]];	then
		mkdir -p "${ROOT}${KDEDIR}/share/apps/kdm/faces"
		cp "${ROOT}${KDEDIR}/share/apps/kdm/pics/users/default1.png" \
			"${ROOT}${KDEDIR}/share/apps/kdm/faces/.default.face.icon"
	fi
	if [[ ! -e "${ROOT}${KDEDIR}/share/apps/kdm/faces/root.face.icon" ]]; then
		mkdir -p "${ROOT}${KDEDIR}/share/apps/kdm/faces"
		cp "${ROOT}${KDEDIR}/share/apps/kdm/pics/users/root1.png" \
			"${ROOT}${KDEDIR}/share/apps/kdm/faces/root.face.icon"
	fi
}
