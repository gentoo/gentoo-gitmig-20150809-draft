# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-freebsd/freebsd-sources/freebsd-sources-6.1_rc1.ebuild,v 1.1 2006/04/30 20:17:44 flameeyes Exp $

inherit bsdmk freebsd

DESCRIPTION="FreeBSD kernel sources"
SLOT="${PVR}"
KEYWORDS="~x86-fbsd"

IUSE="symlink"

SRC_URI="mirror://gentoo/${SYS}.tar.bz2"

RDEPEND=">=sys-freebsd/freebsd-mk-defs-6.0-r1"
DEPEND=""

RESTRICT="nostrip"

S=${WORKDIR}/sys

MY_PVR="${PVR}"

[[ ${MY_PVR} == "${RV}" ]] && MY_PVR="${MY_PVR}-r0"

src_unpack() {
	unpack ${A}
	cd ${S}

	# This replaces the gentoover patch, it doesn't need reapply every time.
	sed -i -e 's:^REVISION=.*:REVISION="'${PVR}'":' \
		-e 's:^BRANCH=.*:BRANCH="Gentoo":' \
		-e 's:^VERSION=.*:VERSION="${TYPE} ${BRANCH} ${REVISION}":' \
		${S}/conf/newvers.sh

	epatch "${FILESDIR}/${PN}-gentoo.patch"
	epatch "${FILESDIR}/${PN}-6.0-flex-2.5.31.patch"
	epatch "${FILESDIR}/${PN}-6.0-asm.patch"
	epatch "${FILESDIR}/${PN}-6.0-werror.patch"

	epatch "${FILESDIR}/SA-06-14-fpu.patch"
}

src_compile() {
	einfo "Nothing to compile.."
}

src_install() {
	insinto /usr/src/sys-${MY_PVR}
	doins -r ${S}/*
}

pkg_postinst() {
	if [[ ! -L ${ROOT}/usr/src/sys ]]; then
		einfo "/usr/src/sys symlink doesn't exist; creating..."
		ln -sf sys-${MY_PVR} ${ROOT}/usr/src/sys || \
			eerror "Couldn't create ${ROOT}/usr/src/sys symlink."
		ln -sf sys-${MY_PVR} ${ROOT}/usr/src/sys-${RV} || \
			eerror "Couldn't create ${ROOT}/usr/src/sys-${RV} symlink."
	elif use symlink; then
		einfo "Updating /usr/src/sys symlink..."
		rm ${ROOT}/usr/src/sys ${ROOT}/usr/src/sys-${RV}
		ln -sf sys-${MY_PVR} ${ROOT}/usr/src/sys || \
			eerror "Couldn't create ${ROOT}/usr/src/sys symlink."
		ln -sf sys-${MY_PVR} ${ROOT}/usr/src/sys-${RV} || \
			eerror "Couldn't create ${ROOT}/usr/src/sys-${RV} symlink."
	fi
}
