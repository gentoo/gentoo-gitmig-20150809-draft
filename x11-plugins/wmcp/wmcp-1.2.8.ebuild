# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmcp/wmcp-1.2.8.ebuild,v 1.1 2002/10/04 14:49:33 raker Exp $

S="${WORKDIR}/${P}"

DESCRIPTION="A pager dockapp"
HOMEPAGE="http://www.the.page.doesnt.seem.to.exist.anymore.com"
SRC_URI="http://linux-sea.tucows.webusenet.com/files/x11/dock/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/glibc
	virtual/x11"
RDEPEND="${DEPEND}"

src_unpack() {

	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/makefile.diff || die "patch failed"

}

src_compile() {

	make || die "make failed"

}

src_install() {

	cd ${S}
	dobin wmcp

}
