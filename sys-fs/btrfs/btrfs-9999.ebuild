# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/btrfs/btrfs-9999.ebuild,v 1.8 2009/04/17 15:16:51 lavajoe Exp $

inherit eutils linux-mod git

DESCRIPTION="A checksumming copy-on-write filesystem"
HOMEPAGE="http://btrfs.wiki.kernel.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

EGIT_REPO_URI="git://git.kernel.org/pub/scm/linux/kernel/git/mason/btrfs-unstable-standalone.git"
EGIT_BRANCH="master"

pkg_setup()
{
	linux-mod_pkg_setup

	BUILD_TARGETS="all"
	BUILD_PARAMS="KERNELDIR=${KV_OUT_DIR}"
	MODULE_NAMES="btrfs(fs:${S})"

	if ! kernel_is gt 2 6 26; then
		eerror "Need a >=2.6.27 kernel to compile against!"
		die "Need a >=2.6.27 kernel to compile against!"
	fi

	if ! linux_chkconfig_present LIBCRC32C; then
		eerror "You need to enable LIBCRC32C in your kernel!"
		die "You need to enable LIBCRC32C in your kernel!"
	fi
}

src_install()
{
	linux-mod_src_install

	dodoc INSTALL
}

pkg_postinst() {
	linux-mod_pkg_postinst

	ewarn "WARNING: Btrfs is under heavy development and is not suitable for"
	ewarn "         any uses other than benchmarking and review."
	ewarn "         The Btrfs disk format is not yet finalized."
	ewarn
	ewarn "         Also, it is highly recommended that the versions of"
	ewarn "         btrfs and btrfs-progs match."
	ewarn
	ewarn "Note: This version is installed from a live ebuild, so the disk"
	ewarn "      format can change from install to install as the upstream"
	ewarn "      source changes."
}
