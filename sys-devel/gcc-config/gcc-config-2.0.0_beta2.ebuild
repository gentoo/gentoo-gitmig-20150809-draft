# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gcc-config/gcc-config-2.0.0_beta2.ebuild,v 1.2 2006/03/28 03:50:17 eradicator Exp $

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

RDEPEND=">=app-admin/eselect-compiler-${PV}"

src_compile() {
	# Just need to make gcc-config from gcc-config.in
	econf
}

src_install() {
	dobin src/profile-manager/gcc-config
}
