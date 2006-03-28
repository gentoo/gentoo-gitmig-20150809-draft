# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/eselect-compiler/eselect-compiler-2.0.0_rc1-r1.ebuild,v 1.2 2006/03/28 03:48:23 eradicator Exp $

inherit eutils

DESCRIPTION="Utility to configure the active toolchain compiler"
HOMEPAGE="http://www.gentoo.org/"

MY_PN="compiler-config"
MY_P="${MY_PN}-${PV}"
S="${WORKDIR}/${MY_P}"

SRC_URI=" http://dev.gentoo.org/~eradicator/toolchain/${MY_PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

RDEPEND=">=app-admin/eselect-1.0_rc1"

pkg_postinst() {
	# Some toolchain.eclass installed confs aren't quite right
	sed -i 's:chost:ctarget:g' ${ROOT}/etc/eselect/compiler/*
	sed -i 's:spec=:specs=:g' ${ROOT}/etc/eselect/compiler/*

	# Migrate from the old configs
	if [[ ! -f "${ROOT}/etc/eselect/compiler/selection.conf" ]] ; then
		# Migrate isn't smart enough to handle the toolchain.eclass
		# installed confs.
		# This should be fixed before it comes out of beta and p.m.
		rm -f ${ROOT}/etc/eselect/compiler/*.conf
		eselect compiler migrate
	fi

	# Update the wrappers
	eselect compiler update

	if rm -f ${ROOT}/etc/env.d/05gcc* &> /dev/null ; then
		ewarn "You should source /etc/profile in your open shells."
	fi

	ewarn "Thanks for beta testing eselect-compiler.  If you have any problems,"
	ewarn "please contact eradicator@gentoo.org."
}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-inherit.patch
}

src_install() {
	dodoc README
	make DESTDIR="${D}" install || die

	# This is installed by sys-devel/gcc-config
	rm ${D}/usr/bin/gcc-config
}
