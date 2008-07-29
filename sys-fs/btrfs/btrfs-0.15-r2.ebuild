# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/btrfs/btrfs-0.15-r2.ebuild,v 1.4 2008/07/29 03:42:26 lavajoe Exp $

inherit eutils linux-mod

DESCRIPTION="A checksumming copy-on-write filesystem"
HOMEPAGE="http://btrfs.wiki.kernel.org/"
SRC_URI="http://www.kernel.org/pub/linux/kernel/people/mason/btrfs/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

pkg_setup()
{
	linux-mod_pkg_setup

	BUILD_TARGETS="all"
	BUILD_PARAMS="KERNELDIR=${KV_OUT_DIR}"
	MODULE_NAMES="btrfs(fs:${S}/"

	if ! kernel_is 2 6; then
		eerror "Need a 2.6 kernel to compile against!"
		die "Need a 2.6 kernel to compile against!"
	fi

	if ! linux_chkconfig_present LIBCRC32C; then
		eerror "You need to enable LIBCRC32C in your kernel!"
		die "You need to enable LIBCRC32C in your kernel!"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${PF}-hotfix.patch"
	epatch "${FILESDIR}/${P}-acl-disable.patch"
}

src_install()
{
	linux-mod_src_install

	dodoc INSTALL TODO
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
	ewarn "Note: If upgrading from 0.14, there is no disk format change,"
	ewarn "      but it might be prudent to fsck after upgrading."
}
