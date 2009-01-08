# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-freebsd/freebsd-sources/freebsd-sources-6.2-r5.ebuild,v 1.1 2009/01/08 18:35:47 aballier Exp $

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
	epatch "${FILESDIR}/${PN}-6.2-gcc41.patch"
	epatch "${FILESDIR}/${PN}-6.2-sparc64.patch"
	epatch "${FILESDIR}/${PN}-6.1-ntfs.patch"
	epatch "${FILESDIR}/${PN}-6.2-debug-O2.patch"
	epatch "${FILESDIR}/${PN}-6.2-dl_iterate_phdr.patch"
	epatch "${FILESDIR}/${PN}-6.2-posix-monotonic-clock.patch"

	# Errata patches
	epatch "${FILESDIR}/${P}-EN-07:02.net.patch"
	epatch "${FILESDIR}/${P}-unp_gc.patch"

	# http://security.freebsd.org/advisories/FreeBSD-SA-07:03.ipv6.asc
	epatch "${FILESDIR}/${P}-ipv6.patch"

	# http://security.freebsd.org/advisories/FreeBSD-SA-07:09.random.asc
	epatch "${FILESDIR}/${P}-random.patch"

	# http://security.freebsd.org/advisories/FreeBSD-SA-08:03.sendfile.asc
	epatch "${FILESDIR}/${P}-sendfile.patch"

	# Fix modules symbol export with latest binutils
	epatch "${FILESDIR}/${PN}-7.0-binutils_link.patch"

	# http://security.freebsd.org/advisories/FreeBSD-SA-08:07.amd64.asc
	epatch "${FILESDIR}/${P}-amd64.patch"

	# http://security.freebsd.org/advisories/FreeBSD-SA-08:09.icmp6.asc
	epatch "${FILESDIR}/${P}-icmp6.patch"

	# http://security.freebsd.org/advisories/FreeBSD-SA-08:10.nd6.asc
	epatch "${FILESDIR}/${P}-nd6-6.patch"

	# http://security.freebsd.org/advisories/FreeBSD-SA-08:11.arc4random.asc
	epatch "${FILESDIR}/${P}-arc4random6x.patch"

	# http://security.freebsd.org/advisories/FreeBSD-SA-08:13.protosw.asc
	epatch "${FILESDIR}/${P}-protosw6x.patch"

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
