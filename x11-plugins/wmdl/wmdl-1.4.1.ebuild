# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmdl/wmdl-1.4.1.ebuild,v 1.11 2005/04/28 21:34:46 wormo Exp $

inherit eutils

IUSE=""
DESCRIPTION="WindowMaker Doom Load dockapp"
HOMEPAGE="http://the.homepage.doesnt.appear.to.exist.anymore.com"
SRC_URI="http://www.ibiblio.org/pub/linux/distributions/gentoo/distfiles/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ~sparc ~ppc"

DEPEND="virtual/libc
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
