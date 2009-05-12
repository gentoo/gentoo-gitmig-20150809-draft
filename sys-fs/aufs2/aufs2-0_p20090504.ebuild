# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/aufs2/aufs2-0_p20090504.ebuild,v 1.1 2009/05/12 17:36:00 tommy Exp $

EGIT_REPO_URI="http://git.c3sl.ufpr.br/pub/scm/aufs/aufs2-standalone.git"

inherit git linux-mod toolchain-funcs

DESCRIPTION="An entirely re-designed and re-implemented Unionfs"
HOMEPAGE="http://aufs.sourceforge.net"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="hinotify debug"

DEPEND=""
RDEPEND="!sys-fs/aufs"

MODULE_NAMES="aufs(misc:${S})"

pkg_setup() {
	get_version
	if ! grep -qs "EXPORT_SYMBOL(deny_write_access);" ${KV_DIR}/fs/namei.c; then
		ewarn "Patching your kernel..."
		cd ${KV_DIR}
		if kernel_is eq 2 6 27; then
			epatch "${FILESDIR}"/aufs2-standalone.patch
		elif kernel_is eq 2 6 28; then
			epatch "${FILESDIR}"/aufs2-standalone.patch
		elif kernel_is eq 2 6 29; then
			epatch "${FILESDIR}"/aufs2-standalone-29.patch
		else
			die "no supported kernel found"
		fi
		elog "You need to compile your kernel with the applied patch"
		elog "to be able to load and use the aufs kernel module"
	fi

	linux-mod_pkg_setup
}
src_unpack() {
	if kernel_is eq 2 6 27; then
		EGIT_BRANCH="aufs2-27"
		EGIT_TREE="bb1af7c7e7b5367f1bdc65586712a2519c032f07"
	elif kernel_is eq 2 6 28; then
		EGIT_BRANCH="aufs2-28"
		EGIT_TREE="a69e4ba24b8b6896bc2a654b5b4436102fcd0441"
	elif kernel_is eq 2 6 29; then
		EGIT_BRANCH="aufs2-29"
		EGIT_TREE="64b47672ffed5dd1ac4754146641494a69dd88ad"
	else
		die "no supported kernel found"
	fi
	git_src_unpack
	cd "${S}"
	echo -e "CONFIG_AUFS_BRANCH_MAX_127 = y\nAUFS_DEF_CONFIG = -DCONFIG_AUFS_MODULE -UCONFIG_AUFS" >> fs/aufs/magic.mk

	use hinotify && echo "CONFIG_AUFS_HINOTIFY = y" >> fs/aufs/magic.mk
	use debug && echo "CONFIG_AUFS_DEBUG = y" >> fs/aufs/magic.mk

	tail -n 14 config.mk >> fs/aufs/magic.mk
	echo -e "ccflags-y += -I\${S}/include\nccflags-y += \${AUFS_DEF_CONFIG}" >> fs/aufs/magic.mk

	EGIT_REPO_URI="http://git.c3sl.ufpr.br/pub/scm/aufs/aufs2-util.git"
	EGIT_TREE="cf1c9a7766a2605dd95ceecc0ac0a5396e784f6d"
	EGIT_PROJECT="aufs2-utils"
	EGIT_BRANCH=""
	S=${S}-utils
	git_src_unpack
	cd "${S}"
	epatch "${FILESDIR}"/utils-Makefile.patch
	S=${S/-utils}
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
	doman Documentation/filesystems/aufs/aufs.5 || die
	dodoc Documentation/filesystems/aufs/README || die
	docinto design
	dodoc Documentation/filesystems/aufs/design/*.txt || die
	cd "${S}"-utils
	emake DESTDIR="${D}" install || die
	docinto
	newdoc README README-utils || die
}
