# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xdiskusage/xdiskusage-1.44.ebuild,v 1.1 2002/11/12 23:07:32 raker Exp $

DESCRIPTION="du frontend for graphically viewing disk usage"
HOMEPAGE="http://xdiskusage.sourceforge.net"
SRC_URI="http://xdiskusage.sourceforge.net/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""

DEPEND="virtual/x11
	>=x11-libs/fltk-1.1.0"

S="${WORKDIR}/${P}"

src_compile() {

	export CXX="g++"

	econf || die "configure failed"

	cp makeinclude makeinclude.orig
	sed -e "s:-O2:${CXXFLAGS} -I/usr/include/fltk-1.1:" \
		< makeinclude.orig > makeinclude

	make || die "parallel make failed"

}

src_install() {

	dobin xdiskusage
	doman xdiskusage.1
	dodoc README

}
