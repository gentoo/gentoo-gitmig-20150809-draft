# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/cll1h/cll1h-0.6-r1.ebuild,v 1.2 2012/11/12 12:07:00 blueness Exp $

EAPI=4

DESCRIPTION="C<<1 programming language system"
HOMEPAGE="http://gpl.arachne.cz/"
SRC_URI="http://gpl.arachne.cz/download/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~amd64-linux ~ppc ~ppc64 ~x86 ~x86-linux ~ppc-macos"
IUSE=""

DEPEND=""
RDEPEND="sys-devel/gcc"

src_install() {
	insinto /usr/include
	doins cll1.h
	dodoc cll1.txt
	docinto examples
	dodoc demos/*.c
	docompress -x /usr/share/doc/"${PF}"/examples
}
