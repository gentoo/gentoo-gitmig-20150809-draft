# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/knocker/knocker-0.7.1-r2.ebuild,v 1.2 2012/11/13 20:29:26 blueness Exp $

EAPI="4"

inherit base toolchain-funcs

DESCRIPTION="Knocker is an easy to use security port scanner written in C"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://knocker.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ppc ~sparc ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

DOCS="AUTHORS BUGS ChangeLog NEWS README TO-DO"

PATCHES=( "${FILESDIR}"/${P}-free.patch )

src_compile() {
	emake CC="$(tc-getCC)"
}
