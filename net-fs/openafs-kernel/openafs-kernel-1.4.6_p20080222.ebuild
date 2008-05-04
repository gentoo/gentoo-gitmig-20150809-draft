# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/openafs-kernel/openafs-kernel-1.4.6_p20080222.ebuild,v 1.4 2008/05/04 13:40:15 maekke Exp $

inherit eutils linux-mod versionator toolchain-funcs

PATCHVER=0.14
MY_PN=${PN/-kernel}
MY_PV_DATE=${PV#*_p}
MY_PV=${PV%_p*}
MY_P=${MY_PN}-${MY_PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="The OpenAFS distributed file system kernel module"
HOMEPAGE="http://www.openafs.org/"
SRC_URI="http://openafs.org/dl/${MY_PV}/${MY_P}-src.tar.bz2
	mirror://gentoo/${MY_PN}-gentoo-${PATCHVER}.tar.bz2
	mirror://gentoo/${MY_PN}-${MY_PV}-cvs${MY_PV_DATE}.patch.bz2"

LICENSE="IBM openafs-krb5 openafs-krb5-a APSL-2 sun-rpc"
SLOT="0"
KEYWORDS="~alpha amd64 ~ppc ~ppc64 ~sparc x86"
IUSE=""

PATCHDIR=${WORKDIR}/gentoo/patches/$(get_version_component_range 1-2)

CONFIG_CHECK="!DEBUG_RODATA ~!AFS_FS"
ERROR_DEBUG_RODATA="OpenAFS is incompatible with linux' CONFIG_DEBUG_RODATA option"
ERROR_AFS_FS="OpenAFS conflicts with the in-kernel AFS-support.  Make sure not to load both at the same time!"

pkg_setup() {
	linux-mod_pkg_setup
}

src_unpack() {
	unpack ${MY_P}-src.tar.bz2
	unpack ${MY_PN}-gentoo-${PATCHVER}.tar.bz2
	cd "${S}"

	epatch "${DISTDIR}"/${MY_P}-cvs${MY_PV_DATE}.patch.bz2

	EPATCH_SUFFIX="patch" epatch ${PATCHDIR}

	./regen.sh || die "Failed: regenerating configure script"
}

src_compile() {
	ARCH="$(tc-arch-kernel)" econf --with-linux-kernel-headers=${KV_DIR} || die "Failed: econf"

	ARCH="$(tc-arch-kernel)" emake -j1 only_libafs || die "Failed: emake"
}

src_install() {
	MOD_SRCDIR=$(expr ${S}/src/libafs/MODLOAD-*)
	[ -f ${MOD_SRCDIR}/libafs.${KV_OBJ} ] \
			|| die "Couldn't find compiled kernel module"

	MODULE_NAMES='libafs(fs/openafs:$MOD_SRCDIR)'

	linux-mod_src_install
}
