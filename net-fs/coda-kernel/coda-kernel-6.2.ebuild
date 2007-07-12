# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/coda-kernel/coda-kernel-6.2.ebuild,v 1.2 2007/07/12 05:38:40 mr_bones_ Exp $

inherit linux-mod

MY_PN=linux-coda
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Kernel module for the Coda Filesystem. The stock module will not work for Coda versions 6.0 and above."
HOMEPAGE="http://www.coda.cs.cmu.edu/"
SRC_URI="ftp://ftp.coda.cs.cmu.edu/pub/coda/linux/kernel/${MY_P}.tgz"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~mips ~amd64 ~ia64"
IUSE=""

pkg_setup() {
	if kernel_is 2 4; then
		MODULE_NAMES="coda(coda:${S}/linux2.4)"
	elif kernel_is 2 6; then
		MODULE_NAMES="coda(coda:${S}/linux2.6)"
	else
		die "Unsupported kernel"
	fi

	BUILD_TARGETS="all"
	CONFIG_CHECK="!CODA_FS"
	CODA_FS_ERROR="You must disable \"Coda file system support\" in your kernel configuration, because it conflicts with this package."
	linux-mod_pkg_setup
	BUILD_PARAMS="KVER=${KV_FULL} KSRC=${KV_DIR}"
}
