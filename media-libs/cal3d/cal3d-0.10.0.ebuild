# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/cal3d/cal3d-0.10.0.ebuild,v 1.4 2006/01/26 23:14:57 marienz Exp $

inherit eutils

MY_P=${P/cal3d/cal3d-full}
DESCRIPTION="skeletal based character animation library"
HOMEPAGE="http://cal3d.sourceforge.net/"
SRC_URI="mirror://sourceforge/cal3d/${MY_P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND=""
DEPEND=">=sys-devel/automake-1.4
	>=sys-devel/autoconf-2.13"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/cal3d-0.11.0_pre20050823-libtool-compat.patch"
}

src_compile() {
	./autogen.sh || die "autogen failed"
	econf || die
	emake || die
}

src_install() {
	make install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog README TODO
}
