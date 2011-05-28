# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/makedev/makedev-3.23.1.ebuild,v 1.6 2011/05/28 20:42:26 xarthisius Exp $

EAPI="2"

inherit eutils toolchain-funcs

MY_PN="MAKEDEV"
MY_VER=${PV%.*}
MY_REL=${PV#${MY_VER}.}
MY_P="${MY_PN}-${MY_VER}"
DESCRIPTION="program used for creating device files in /dev"
HOMEPAGE="http://people.redhat.com/nalin/MAKEDEV/"
SRC_URI="http://people.redhat.com/nalin/MAKEDEV/${MY_P}-${MY_REL}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ppc ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="build selinux"

RDEPEND="!<sys-apps/baselayout-2.0.0_rc"
DEPEND=""

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${FILESDIR}"/${P}-headers.patch #339674
}

src_compile() {
	use selinux && export SELINUX=1
	emake CC=$(tc-getCC) OPTFLAGS="${CFLAGS}" || die
}

src_install() {
	# set devdir to makedevdir so we dont have to worry about /dev
	emake install DESTDIR="${D}" makedevdir=/sbin devdir=/sbin || die
	dodoc *.txt
	keepdir /dev
}

pkg_postinst() {
	use build && MAKEDEV -d "${ROOT}"/dev generic
}
