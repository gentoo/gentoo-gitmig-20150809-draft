# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/syslinux/syslinux-3.31.ebuild,v 1.1 2006/10/22 06:02:10 vapier Exp $

inherit eutils

DESCRIPTION="SysLinux, IsoLinux and PXELinux bootloader"
HOMEPAGE="http://syslinux.zytor.com/"
SRC_URI="mirror://kernel/linux/utils/boot/syslinux/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""

RDEPEND="sys-fs/mtools"
DEPEND="${RDEPEND}
	dev-lang/nasm"

# This ebuild is a departure from the old way of rebuilding everything in syslinux
# This departure is necessary since hpa doesn't support the rebuilding of anything other
# than the installers.

# removed all the unpack/patching stuff since we aren't rebuilding the core stuff anymore

src_unpack() {
	unpack ${A}
	cd "${S}"
	rm -f gethostip #137081
	epatch "${FILESDIR}"/syslinux-3.31-nossp.patch
	epatch "${FILESDIR}"/syslinux-3.11-nopie.patch
}

src_compile() {
	emake installer || die
}

src_install() {
	make INSTALLROOT="${D}" install || die
	dodoc README* NEWS TODO *.doc memdisk/memdisk.doc
}
