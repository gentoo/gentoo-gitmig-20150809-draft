# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/mindi/mindi-0.65.ebuild,v 1.1 2002/07/23 22:09:52 lostlogic Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Mindi builds boot/root disk images using your existing kernel, modules, tools and libraries"
HOMEPAGE="http://www.microwerks.net/~hugo/mindi/"
SRC_URI="http://www.microwerks.net/~hugo/kp/${P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=sys-apps/bzip2-1.0.1
	>=app-cdr/cdrtools-1.11
	>=sys-libs/ncurses-5
	>=sys-devel/binutils-2
	>=sys-apps/syslinux-1.7
	>=sys-apps/lilo-22
	>=app-admin/dosfstools-2.8"

RDEPEND="${DEPEND}"

src_unpack() {

	unpack ${A}
	cd ${S}
	patch -p0 < ${FILESDIR}/${P}.patch || die "patching failed"
}

src_install() {
	dodir /usr/share/mindi
	dodir /usr/sbin
	cp * --parents -rdf ${D}/usr/share/mindi/
	dosym /usr/share/mindi/mindi /usr/sbin/
	dosym /usr/share/mindi/analyze-my-lvm /usr/sbin
}
