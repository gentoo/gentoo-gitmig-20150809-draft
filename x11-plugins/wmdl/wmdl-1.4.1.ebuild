# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmdl/wmdl-1.4.1.ebuild,v 1.3 2003/02/13 17:29:06 vapier Exp $

S="${WORKDIR}/${P}"

DESCRIPTION="WindowMaker Doom Load dockapp"
HOMEPAGE="http://the.homepage.doesnt.appear.to.exist.anymore.com"
SRC_URI="http://www.ibiblio.org/pub/linux/distributions/gentoo/distfiles/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/glibc
	virtual/x11"

src_unpack() {

	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/makefile.diff || die "patch failed"

}

src_compile() {

	make || die "parallel make failed"

}

src_install() {

	cd ${S}
	dobin wmdl

}
