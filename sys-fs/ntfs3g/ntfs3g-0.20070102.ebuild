# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/ntfs3g/ntfs3g-0.20070102.ebuild,v 1.1 2007/01/01 23:12:27 chutzpah Exp $

inherit linux-info

MY_PN="${PN/3g/-3g}"
MY_PV="${PV}-BETA"
MY_P="${MY_PN}-${MY_PV}"

DESCRIPTION="Open source read-write NTFS driver that runs under FUSE"
HOMEPAGE="http://www.ntfs-3g.org"
SRC_URI="http://www.ntfs-3g.org/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=sys-fs/fuse-2.6.0"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S="${WORKDIR}/${MY_P}"

CONFIG_CHECK="!FUSE_FS"
ERR=" ${BAD}*${NORMAL}  "
ERROR_FUSE_FS="For this version of ntfs-3g to work properly, you need to use the
$ERR kernel module included in the package, not the kernel version. To do this
$ERR remove FUSE from your kernel, recompile it then remerge FUSE.
$ERR
$ERR    emerge -a1 sys-fs/fuse
$ERR
$ERR You will need to reboot if you had FUSE in your kernel, if it was a module, this
$ERR should be enough:
$ERR
$ERR    modprobe -r fuse
$ERR    modprobe fuse
$ERR
$ERR If either of these commands have an error, you will need to reboot.
$ERR"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# default makefile calls ldconfig
	sed -ie '/ldconfig$/ d' src/Makefile.*
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS ChangeLog CREDITS NEWS README
}
