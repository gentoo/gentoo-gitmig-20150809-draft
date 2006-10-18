# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/openafs-kernel/openafs-kernel-1.4.2.ebuild,v 1.1 2006/10/18 06:37:31 stefaan Exp $

inherit eutils linux-mod versionator toolchain-funcs

PATCHVER=0.9
MY_PN=${PN/-kernel}
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="The OpenAFS distributed file system kernel module"
HOMEPAGE="http://www.openafs.org/"
SRC_URI="http://openafs.org/dl/${MY_PN}/${PV}/${MY_P}-src.tar.bz2
	mirror://gentoo/${MY_PN}-gentoo-${PATCHVER}.tar.bz2"

LICENSE="IPL-1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~x86"
IUSE=""

PATCHDIR=${WORKDIR}/gentoo/patches/$(get_version_component_range 1-2)

CONFIG_CHECK="!DEBUG_RODATA"
DEBUG_RODATA_ERROR="OpenAFS is incompatible with linux' CONFIG_DEBUG_RODATA option"

pkg_setup() {
	linux-mod_pkg_setup
}

src_unpack() {
	unpack ${A}; cd ${S}

	EPATCH_SUFFIX="patch" epatch ${PATCHDIR}

	./regen.sh || die "Failed: regenerating configure script"
}

src_compile() {
	ARCH="$(tc-arch-kernel)" econf --with-linux-kernel-headers=${KV_DIR} || die "Failed: econf"

	ARCH="$(tc-arch-kernel)" emake only_libafs || die "Failed: emake"
}

src_install() {
	MOD_SRCDIR=$(expr ${S}/src/libafs/MODLOAD-*)
	[ -f ${MOD_SRCDIR}/openafs.${KV_OBJ} ] \
			|| die "Couldn't find compiled kernel module"

	MODULE_NAMES='openafs(fs/openafs:$MOD_SRCDIR)'

	linux-mod_src_install
}

