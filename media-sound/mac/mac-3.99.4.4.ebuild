# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mac/mac-3.99.4.4.ebuild,v 1.1 2006/03/21 16:13:03 sbriesen Exp $

inherit eutils

# weird version string :-/
MY_P=$(printf "%s-%d.%d-u%d-b%d" ${PN} ${PV//./ })

DESCRIPTION="Monkey's Audio lossless audio codec"
HOMEPAGE="http://sourceforge.net/projects/mac-port/"
SRC_URI="mirror://sourceforge/mac-port/${MY_P}.tar.gz"

LICENSE="MAC"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="x86? ( dev-lang/nasm )"
RDEPEND=""

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# fix CXXFLAGS 
	sed -i -e "s:^\(CXXFLAGS=.*\)-O3 \(.*\):\1\2:g" configure*

	# fix NASM source
	epatch "${FILESDIR}/${MY_P}-nxstack.diff"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO src/*.txt
	dohtml src/*.htm
}
