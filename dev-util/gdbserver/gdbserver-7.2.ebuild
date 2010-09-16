# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/gdbserver/gdbserver-7.2.ebuild,v 1.1 2010/09/16 10:27:34 flameeyes Exp $

EAPI=3

inherit eutils flag-o-matic

PATCH_VER="1"

MY_P="gdb-${PV}"

PATCH_VER="1"
DESCRIPTION="GNU debugger"
HOMEPAGE="http://sources.redhat.com/gdb/"
SRC_URI="http://ftp.gnu.org/gnu/gdb/${MY_P}.tar.bz2
	ftp://sources.redhat.com/pub/gdb/releases/${MY_P}.tar.bz2
	${PATCH_VER:+!vanilla? ( mirror://gentoo/${MY_P}-patches-${PATCH_VER}.tar.xz )}"

LICENSE="GPL-2"

KEYWORDS="~amd64"
IUSE="${PATCH_VER:+vanilla}"
SLOT="0"

RDEPEND=""
DEPEND="${RDEPEND}
	${PATCH_VER:+!vanilla? ( app-arch/xz-utils )}"
RDEPEND="${RDEPEND}
	!>=sys-devel/gdb-7.2"

S="${WORKDIR}/${MY_P}/gdb/gdbserver"

src_prepare() {
	cd "${WORKDIR}"/${MY_P}
	use vanilla || [[ -n ${PATCH_VER} ]] && EPATCH_SUFFIX="patch" epatch "${WORKDIR}"/patch
}

gdb_branding() {
	printf "Gentoo ${PV} "
	if [[ -n ${PATCH_VER} ]] && ! use vanilla; then
		printf "p${PATCH_VER}"
	else
		printf "vanilla"
	fi
}

src_configure() {
	strip-unsupported-flags
	econf \
		--with-pkgversion="$(gdb_branding)" \
		--with-bugurl='http://bugs.gentoo.org/'
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc ChangeLog README || die
}

pkg_postinst() {
	elog "To attach to a gdbserver instance you're going to need the expat"
	elog "USE flag for gdb to be enabled on the debug host (not the target)"
	elog "otherwise it will fail to properly attach."
	elog ""
	elog "Remember that to cross-debug a target with a different architecture"
	elog "you need a gdb for the same target, which gets installed with the"
	elog "sys-devel/crossdev package and the --ex-gdb flag."
}
