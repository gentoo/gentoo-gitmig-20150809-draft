# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/cowloop/cowloop-3.1.ebuild,v 1.1 2009/02/24 11:56:00 dragonheart Exp $

EAPI=2
inherit linux-mod toolchain-funcs

DESCRIPTION="A copy-on-write loop driver (block device) to be used on top of any other block driver"
HOMEPAGE="http://www.atcomputing.nl/Tools/cowloop/"
SRC_URI="http://www.atcomputing.nl/Tools/cowloop/packages/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
DEPEND=""
RDEPEND=""

S=${WORKDIR}/${P}/src
MODULE_NAMES="cowloop(fs:)"
BUILD_TARGETS="modules"

pkg_setup() {
	linux-mod_pkg_setup
	BUILD_PARAMS="-C ${KV_DIR} SUBDIRS=${S} -I."
	einfo "Linux kernel ${KV_FULL}"
	if kernel_is lt 2 6
	then
		eerror "This version only works with 2.6 kernels"
		eerror "For 2.4 kernel support, use version 1.4"
		die "No compatible kernel detected!"
	fi
}

src_compile() {
	touch .gpl_license_accepted
	linux-mod_src_compile
	CC="$(tc-getCC)" emake utils || die "make failed"
}

src_install() {
	linux-mod_src_install
	emake DESTDIR="${D}" install-utils install-man || die 'make failed'
	dodoc "${S}"/../RELEASENOTES.3.1 "${S}"/../HOWTO.install ../doc/* \
		../testing/*
	dodir /etc/udev/rules.d
	echo 'KERNEL=="cowctl"        NAME="cow/ctl"' > "${D}"/etc/udev/rules.d/70-cow.rules
	echo 'KERNEL=="cow[0-9]*"  NAME="cow/%n"' >> "${D}"/etc/udev/rules.d/70-cow.rules
}
