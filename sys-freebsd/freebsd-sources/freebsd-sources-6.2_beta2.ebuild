# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-freebsd/freebsd-sources/freebsd-sources-6.2_beta2.ebuild,v 1.4 2006/10/23 22:05:40 the_paya Exp $

inherit bsdmk freebsd flag-o-matic

DESCRIPTION="FreeBSD kernel sources"
SLOT="${PVR}"
KEYWORDS="~sparc-fbsd ~x86-fbsd"

IUSE="symlink"

SRC_URI="mirror://gentoo/${SYS}.tar.bz2"

RDEPEND=">=sys-freebsd/freebsd-mk-defs-6.0-r1"
DEPEND=""

RESTRICT="strip binchecks"

S="${WORKDIR}/sys"

MY_PVR="${PVR}"

[[ ${MY_PVR} == "${RV}" ]] && MY_PVR="${MY_PVR}-r0"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# This replaces the gentoover patch, it doesn't need reapply every time.
	sed -i -e 's:^REVISION=.*:REVISION="'${PVR}'":' \
		-e 's:^BRANCH=.*:BRANCH="Gentoo":' \
		-e 's:^VERSION=.*:VERSION="${TYPE} ${BRANCH} ${REVISION}":' \
		"${S}/conf/newvers.sh"

	epatch "${FILESDIR}/${PN}-gentoo.patch"
	epatch "${FILESDIR}/${PN}-6.0-flex-2.5.31.patch"
	epatch "${FILESDIR}/${PN}-6.0-asm.patch"
	epatch "${FILESDIR}/${PN}-6.0-werror.patch"
	epatch "${FILESDIR}/${PN}-6.1-gcc41.patch"
	epatch "${FILESDIR}/${PN}-6.1-intrcnt.patch"
	epatch "${FILESDIR}/${PN}-6.2-sparc64.patch"
	epatch "${FILESDIR}/${PN}-6.1-ntfs.patch"

	# This is to be able to use sandbox safely, see bug #146284
	epatch "${FILESDIR}/${PN}-6.1-devfs-deadlock.patch"

	# Disable SSP for the kernel
	grep -Zlr -- -ffreestanding "${S}" | xargs -0 sed -i -e \
		"s:-ffreestanding:-ffreestanding $(test-flags -fno-stack-protector -fno-stack-protector-all):g"
}

src_compile() {
	einfo "Nothing to compile.."
}

src_install() {
	insinto "/usr/src/sys-${MY_PVR}"
	doins -r "${S}/"*
}

pkg_postinst() {
	if [[ ! -L "${ROOT}/usr/src/sys" ]]; then
		einfo "/usr/src/sys symlink doesn't exist; creating symlink to sys-${MY_PVR}..."
		ln -sf "sys-${MY_PVR}" "${ROOT}/usr/src/sys" || \
			eerror "Couldn't create ${ROOT}/usr/src/sys symlink."
		# just in case...
		[[ -L ""${ROOT}/usr/src/sys-${RV}"" ]] && rm "${ROOT}/usr/src/sys-${RV}"
		ln -sf "sys-${MY_PVR}" "${ROOT}/usr/src/sys-${RV}" || \
			eerror "Couldn't create ${ROOT}/usr/src/sys-${RV} symlink."
	elif use symlink; then
		einfo "Updating /usr/src/sys symlink to sys-${MY_PVR}..."
		rm "${ROOT}/usr/src/sys" "${ROOT}/usr/src/sys-${RV}" || \
			eerror "Couldn't remove previous symlinks, please fix manually."
		ln -sf "sys-${MY_PVR}" "${ROOT}/usr/src/sys" || \
			eerror "Couldn't create ${ROOT}/usr/src/sys symlink."
		ln -sf "sys-${MY_PVR}" "${ROOT}/usr/src/sys-${RV}" || \
			eerror "Couldn't create ${ROOT}/usr/src/sys-${RV} symlink."
	fi

	if use sparc-fbsd ; then
		ewarn "WARNING: kldload currently causes kernel panics"
		ewarn "on sparc64. This is probably a gcc-4.1 issue, but"
		ewarn "we need gcc-4.1 to compile the kernel correctly :/"
		ewarn "Please compile all modules you need into the kernel"
	fi
}
