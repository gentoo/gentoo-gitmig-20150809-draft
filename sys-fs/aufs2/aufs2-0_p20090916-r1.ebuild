# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/aufs2/aufs2-0_p20090916-r1.ebuild,v 1.1 2009/11/26 18:01:48 tommy Exp $

EAPI="2"

inherit linux-mod toolchain-funcs

DESCRIPTION="An entirely re-designed and re-implemented Unionfs"
HOMEPAGE="http://aufs.sourceforge.net"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug inotify kernel-patch nfs ramfs"

DEPEND="dev-util/git"
RDEPEND="!sys-fs/aufs"

S=${WORKDIR}/${PN}-standalone

MODULE_NAMES="aufs(misc:${S})"

pkg_setup() {
	get_version
	kernel_is lt 2 6 27 && die "kernel too old"
	kernel_is gt 2 6 31 && die "kernel too new"

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
	linux-mod_pkg_setup
}

src_prepare() {
	local branch=origin/aufs2-${KV_PATCH}
	if [[ $KV_PATCH == 31 ]] ; then
		branch=origin/aufs2
	fi
	git checkout -q $branch || die
	if ! use debug; then
		sed -i "s:DEBUG = y:DEBUG =:g" config.mk || die
	fi
	if use inotify; then
		sed -i  "s:HINOTIFY =:HINOTIFY = y:g" config.mk || die
	fi
	if use ramfs; then
		sed -i  "s:RAMFS =:RAMFS = y:g" config.mk || die
	fi

	cd "${WORKDIR}"/${PN}-util
	sed -i "/LDFLAGS += -static -s/d" Makefile || die
	epatch "${FILESDIR}"/{${P}-makefile.patch.bz2,utils-2.6.31.patch}
}

src_compile() {
	local myargs="" ARCH=i386
	use nfs && myargs="CONFIG_EXPORTFS=y CONFIG_AUFS_EXPORT=y "
	use nfs && use amd64 && myargs+="CONFIG_AUFS_INO_T_64=y"
	use amd64 && ARCH=x86_64
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
	emake DESTDIR="${D}" install || die
	docinto
	newdoc README README-utils || die
}
