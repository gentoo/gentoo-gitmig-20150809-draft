# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmdl/wmdl-1.4.1.ebuild,v 1.5 2004/01/04 12:54:55 aliz Exp $

S="${WORKDIR}/${P}"

DESCRIPTION="WindowMaker Doom Load dockapp"
HOMEPAGE="http://the.homepage.doesnt.appear.to.exist.anymore.com"
SRC_URI="http://www.ibiblio.org/pub/linux/distributions/gentoo/distfiles/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"

DEPEND="virtual/glibc
	virtual/x11"

src_unpack() {
	unpack ${A} ; cd ${S}
	epatch ${FILESDIR}/makefile.diff

}

src_compile() {
	make || die "parallel make failed"
}

src_install() {
	dobin wmdl
}
