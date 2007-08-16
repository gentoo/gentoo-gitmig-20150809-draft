# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/vzquota/vzquota-3.0.11.ebuild,v 1.1 2007/08/16 09:40:26 phreak Exp $

DESCRIPTION="OpenVZ VPS disk quota utility"
HOMEPAGE="http://openvz.org/download/utils/vzquota/"
SRC_URI="http://download.openvz.org/utils/${PN}/${PV}/src/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_unpack() {
	unpack ${A}
	# Prevent the Makefile from stripping the binaries, since portage does that
	# already with prestrip
	ebegin "Applying ${P}-Makefile-stripping.patch"
	sed -i 's,$(INSTALL) -s -m,$(INSTALL) -m,' "${S}"/src/Makefile
	eend $?
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
}
