# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/tendra/tendra-5.0_pre20070510-r2.ebuild,v 1.2 2009/12/23 19:53:47 truedfx Exp $

inherit bsdmk eutils flag-o-matic multilib

REV=1073
PATCHVER=1.6

DESCRIPTION="A C/C++ compiler initially developed by DERA"
HOMEPAGE="http://www.tendra.org/"
SRC_URI="mirror://gentoo/${PN}-${REV}.tbz2
	mirror://gentoo/${PN}-patches-${PATCHVER}.tbz2
	http://dev.gentoo.org/~truedfx/${PN}-${REV}.tbz2
	http://dev.gentoo.org/~truedfx/${PN}-patches-${PATCHVER}.tbz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
# Both tendra and tinycc install /usr/bin/tcc
RDEPEND="!dev-lang/tcc"

S=${WORKDIR}/trunk

pkg_setup() {
	export BMAKE="$(get_bmake) ${MAKEOPTS}"

	use amd64 && multilib_toolchain_setup x86
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${WORKDIR}"/tendra-patches/*.patch
}

src_compile() {
	replace-flags '-O*' '-O'

	HOSTARCH=i386 PREFIX=/usr sh makedefs || die "makedefs failed"
	${BMAKE} -DBOOTSTRAP || die "bootstrap failed"
	${BMAKE} || die "build failed"
}

src_install() {
	${BMAKE} PREFIX="${D}usr" \
		MAN_DIR='${PREFIX}/share/man' install || die "install failed"
}
