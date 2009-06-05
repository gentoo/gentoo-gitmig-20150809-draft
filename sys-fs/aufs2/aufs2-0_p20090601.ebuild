# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/aufs2/aufs2-0_p20090601.ebuild,v 1.1 2009/06/05 17:20:53 tommy Exp $

EGIT_REPO_URI="http://git.c3sl.ufpr.br/pub/scm/aufs/aufs2-standalone.git"

inherit git linux-mod toolchain-funcs

DESCRIPTION="An entirely re-designed and re-implemented Unionfs"
HOMEPAGE="http://aufs.sourceforge.net"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug hinotify ramfs"

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
		EGIT_TREE="8e8d6394f50d9cfdc434766ea2434018788ca111"
	elif kernel_is eq 2 6 28; then
		EGIT_BRANCH="aufs2-28"
		EGIT_TREE="78e9abebac8f283dd4f113f392a9943a7b212b0e"
	elif kernel_is eq 2 6 29; then
		EGIT_BRANCH="aufs2-29"
		EGIT_TREE="d2db0dbfac69b5a04df5a78a454a2c9b8c658aa6"
	else
		die "no supported kernel found"
	fi
	git_src_unpack
	cd "${S}"

	use debug || sed -i "s:DEBUG = y:DEBUG =:g" config.mk
	use hinotify && sed -i  "s:HINOTIFY =:HINOTIFY = y:g" config.mk
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
