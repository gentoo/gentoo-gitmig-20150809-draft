# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/atlas-c++/atlas-c++-0.5.92.ebuild,v 1.4 2007/11/25 10:19:45 tupone Exp $

inherit eutils

MY_PN="Atlas-C++"
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Atlas protocol standard implementation in C++.  Atlas protocol is used in role playing games at worldforge."
HOMEPAGE="http://www.worldforge.org/dev/eng/libraries/atlas_cpp"
SRC_URI="mirror://sourceforge/worldforge/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND="virtual/libc
	>=dev-libs/libsigc++-1.2"

src_install() {
	make DESTDIR="${D}" install || die
	#dodoc will install all these docs and a few more
	rm -rf "${D}"/usr/share/doc/${My_P}
	#PR=r0 in this case, but don't fprget to add ${PR} here for non-zero revisions!

	dodoc AUTHORS ChangeLog NEWS README ROADMAP THANKS TODO
}
