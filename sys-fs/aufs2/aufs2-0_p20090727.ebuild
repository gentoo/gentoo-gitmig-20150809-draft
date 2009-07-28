# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/aufs2/aufs2-0_p20090727.ebuild,v 1.1 2009/07/28 18:43:26 tommy Exp $

EGIT_REPO_URI="http://git.c3sl.ufpr.br/pub/scm/aufs/aufs2-standalone.git"

inherit git linux-mod toolchain-funcs

DESCRIPTION="An entirely re-designed and re-implemented Unionfs"
HOMEPAGE="http://aufs.sourceforge.net"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug inotify kernel-patch ramfs"

DEPEND=""
RDEPEND="!sys-fs/aufs"

MODULE_NAMES="aufs(misc:${S})"

get_kernelpatch() {
	if kernel_is eq 2 6 27; then
		KERNELPATCH="aufs2-standalone-27.patch"
		EGIT_BRANCH="aufs2-27"
		EGIT_TREE="957d5a6b6408016f9b074eccc7bffd1429d0a64d"
	elif kernel_is eq 2 6 28; then
		KERNELPATCH="aufs2-standalone-28.patch"
		EGIT_BRANCH="aufs2-28"
		EGIT_TREE="2e3a4181f3d391c72e086fb7ca23b151fc961371"
	elif kernel_is eq 2 6 29; then
		KERNELPATCH="aufs2-standalone-29.patch"
		EGIT_BRANCH="aufs2-29"
		EGIT_TREE="dc5a4600a23ba474a5eb941d4379330e0f36141e"
	elif kernel_is eq 2 6 30; then
		KERNELPATCH="aufs2-standalone-30.patch"
		EGIT_BRANCH="aufs2-30"
		EGIT_TREE="b599d87c0ad475e309f81d9b85ba56527371db81"
	else
		die "no supported kernel found"
	fi
}

pkg_setup() {
	get_version
	get_kernelpatch
	if ! patch -p1 --dry-run --force -R -d ${KV_DIR} < "${FILESDIR}"/${KERNELPATCH} >/dev/null; then
		if use kernel-patch; then
			cd ${KV_DIR}
			ewarn "Patching your kernel..."
			patch --no-backup-if-mismatch --force -p1 -R -d ${KV_DIR} < "${FILESDIR}"/${KERNELPATCH} >/dev/null
			epatch "${FILESDIR}"/${KERNELPATCH}
			einfo "You need to compile your kernel with the applied patch"
			einfo "to be able to load and use the aufs kernel module"
		else
			eerror "You need to apply a patch to your kernel to compile and run the aufs2 module"
			eerror "Either enable the kernel-patch useflag to do it with this ebuild"
			eerror "or apply ${FILESDIR}/${KERNELPATCH} by hand"
			die "missing kernel patch, please apply it first"
		fi
	fi
	linux-mod_pkg_setup
}

src_unpack() {
	git_src_unpack
	cd "${S}"

	use debug || sed -i "s:DEBUG = y:DEBUG =:g" config.mk
	use inotify && sed -i  "s:HINOTIFY =:HINOTIFY = y:g" config.mk
	use ramfs && sed -i  "s:RAMFS =:RAMFS = y:g" config.mk

	EGIT_REPO_URI="http://git.c3sl.ufpr.br/pub/scm/aufs/aufs2-util.git"
	EGIT_TREE="8d4217be37b74732afa80bc6e6519bd9df7ea1af"
	EGIT_PROJECT="aufs2-utils"
	EGIT_BRANCH=""
	local S=${S}-utils
	git_src_unpack
	cd "${S}"
	sed -i "/LDFLAGS += -static -s/d" Makefile
}

src_compile() {
	ARCH=i386
	use amd64 && ARCH=x86_64
	emake CC=$(tc-getCC) CONFIG_AUFS_FS=m KDIR=${KV_DIR} || die
	cd "${S}"-utils
	emake CC=$(tc-getCC) AR=$(tc-getAR) KDIR=${KV_DIR} C_INCLUDE_PATH="${S}"/include || die
}

src_install() {
	linux-mod_src_install
	dodoc README || die
	docinto design
	dodoc design/*.txt || die
	cd "${S}"-utils
	emake DESTDIR="${D}" install || die
	docinto
	newdoc README README-utils || die
}
