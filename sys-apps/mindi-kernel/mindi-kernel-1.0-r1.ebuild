# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/mindi-kernel/mindi-kernel-1.0-r1.ebuild,v 1.1 2004/08/12 21:28:10 pfeifer Exp $

DESCRIPTION="Mindi-kernel is a library of kernel modules, a kernel, and other bits and bobs
used by Mindi."
HOMEPAGE="http://www.mondorescue.org/"
SRC_URI="http://www.microwerks.net/~hugo/download/MondoCD/TGZS/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 -*"
IUSE=""

DEPEND=""
RDEPEND=""

src_install() {
	dodir /usr/share/mindi
	insinto /usr/share/mindi
	doins lib.tar.bz2 vmlinuz
}
