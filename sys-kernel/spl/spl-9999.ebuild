# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/spl/spl-9999.ebuild,v 1.1 2012/01/27 17:01:12 floppym Exp $

EAPI="4"

inherit autotools git-2 linux-mod

DESCRIPTION="The Solaris Porting Layer is a Linux kernel module which provides many of the Solaris kernel APIs"
HOMEPAGE="http://zfsonlinux.org/"
SRC_URI=""
EGIT_REPO_URI="git://github.com/zfsonlinux/spl.git"

LICENSE="|| ( GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="!sys-devel/spl"

src_prepare() {
	AT_M4DIR="config"
	eautoreconf
}

src_configure() {
	set_arch_to_kernel
	econf \
		--with-config=all \
		--with-linux="${KV_DIR}" \
		--with-linux-obj="${KV_OUT}"
}

src_compile() {
	emake
}

src_install() {
	emake DESTDIR="${D}" install
}
