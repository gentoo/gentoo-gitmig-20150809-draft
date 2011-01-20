# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/aufs2/aufs2-0_p20110120.ebuild,v 1.1 2011/01/20 18:25:54 jlec Exp $

EAPI="2"

inherit linux-mod multilib toolchain-funcs

DESCRIPTION="An entirely re-designed and re-implemented Unionfs"
HOMEPAGE="http://aufs.sourceforge.net"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug fuse inotify hardened hfs kernel-patch nfs ramfs"

DEPEND="dev-vcs/git"
RDEPEND="!sys-fs/aufs"

S=${WORKDIR}/${PN}-standalone

MODULE_NAMES="aufs(misc:${S})"

pkg_setup() {
	CONFIG_CHECK="${CONFIG_CHECK} ~EXPERIMENTAL"
	use inotify && CONFIG_CHECK="${CONFIG_CHECK} ~FSNOTIFY"
	use nfs && CONFIG_CHECK="${CONFIG_CHECK} ~EXPORTFS"
	use fuse && CONFIG_CHECK="${CONFIG_CHECK} ~FUSE_FS"
	use hfs && CONFIG_CHECK="${CONFIG_CHECK} ~HFSPLUS_FS"

	# this is needed so merging a binpkg aufs2 is possible w/out a kernel unpacked on the system
	[ -n "$PKG_SETUP_HAS_BEEN_RAN" ] && return

	get_version
	kernel_is lt 2 6 31 && die "kernel too old"
	kernel_is gt 2 6 37 && die "kernel too new"

	linux-mod_pkg_setup
	if ! ( patch -p1 --dry-run --force -R -d ${KV_DIR} < "${FILESDIR}"/aufs2-standalone-${KV_PATCH}.patch >/dev/null && \
		patch -p1 --dry-run --force -R -d ${KV_DIR} < "${FILESDIR}"/aufs2-base-${KV_PATCH}.patch >/dev/null ); then
		if use kernel-patch; then
			cd ${KV_DIR}
			ewarn "Patching your kernel..."
			patch --no-backup-if-mismatch --force -p1 -R -d ${KV_DIR} < "${FILESDIR}"/aufs2-standalone-${KV_PATCH}.patch >/dev/null
			patch --no-backup-if-mismatch --force -p1 -R -d ${KV_DIR} < "${FILESDIR}"/aufs2-base-${KV_PATCH}.patch >/dev/null
			epatch "${FILESDIR}"/aufs2-{base,standalone}-${KV_PATCH}.patch
			elog "You need to compile your kernel with the applied patch"
			elog "to be able to load and use the aufs kernel module"
		else
			eerror "You need to apply a patch to your kernel to compile and run the aufs2 module"
			eerror "Either enable the kernel-patch useflag to do it with this ebuild"
			eerror "or apply ${FILESDIR}/aufs2-base-${KV_PATCH}.patch and"
			eerror "${FILESDIR}/aufs2-standalone-${KV_PATCH}.patch by hand"
			die "missing kernel patch, please apply it first"
		fi
	fi
	export PKG_SETUP_HAS_BEEN_RAN=1
}

src_prepare() {
	local branch=origin/aufs2.1-${KV_PATCH}
	git checkout -q $branch || die
	if ! use debug; then
		sed -i "s:DEBUG = y:DEBUG =:g" config.mk || die
	fi
	if use inotify; then
		sed -i  -e "s:AUFS_HNOTIFY =:AUFS_HNOTIFY = y:g" \
			-e "s:AUFS_HFSNOTIFY =:AUFS_HFSNOTIFY = y:g"  config.mk || die
	fi
	if use ramfs; then
		sed -i  "s:RAMFS =:RAMFS = y:g" config.mk || die
	fi

	sed -i "s:AUFS_RDU =:AUFS_RDU = y:g" config.mk || die

	if use fuse; then
		sed \
			-e "s:AUFS_BR_FUSE =:AUFS_BR_FUSE = y:g" \
			-e "s:AUFS_POLL =:AUFS_POLL = y:g" \
			-i config.mk || die
	fi

	if use hfs; then
		sed -i "s:AUFS_BR_FUSE =:AUFS_BR_FUSE = y:g" config.mk || die
	fi

	if use hardened ; then
		epatch "${FILESDIR}"/pax.patch
	fi

	sed -i "s:aufs.ko usr/include/linux/aufs_type.h:aufs.ko:g" Makefile || die
	sed -i "s:__user::g" include/linux/aufs_type.h || die
	cd "${WORKDIR}"/${PN}-util
	git checkout -q origin/aufs2.1
	sed -i "/LDFLAGS += -static -s/d" Makefile || die
	sed -i -e "s:m 644 -s:m 644:g" -e "s:/usr/lib:/usr/$(get_libdir):g" libau/Makefile || die
}

src_compile() {
	local myargs="" ARCH=x86
	use nfs && myargs="CONFIG_EXPORTFS=y CONFIG_AUFS_EXPORT=y "
	use nfs && use amd64 && myargs+="CONFIG_AUFS_INO_T_64=y"
	emake CC=$(tc-getCC) CONFIG_AUFS_FS=m ${myargs} KDIR=${KV_DIR} || die
	cd "${WORKDIR}"/${PN}-util
	emake CC=$(tc-getCC) AR=$(tc-getAR) KDIR=${KV_DIR} C_INCLUDE_PATH="${S}"/include || die
}

src_install() {
	linux-mod_src_install
	dodoc README || die
	docinto design
	dodoc design/*.txt || die
	cd "${WORKDIR}"/${PN}-util
	emake DESTDIR="${D}" KDIR=${KV_DIR} install || die
	docinto
	newdoc README README-utils || die
}
