# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/cal3d/cal3d-0.11.0_pre20050518.ebuild,v 1.3 2005/08/25 18:41:18 swegener Exp $

inherit debug

DESCRIPTION="Cal3D is a skeletal based character animation library"
HOMEPAGE="http://cal3d.sourceforge.net/"
SRC_URI="mirror://sourceforge/cal3d/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="virtual/libc"

DEPEND=">=sys-devel/automake-1.4
	>=sys-devel/autoconf-2.13"

S=${WORKDIR}/${PN}


src_compile() {
	use debug && my_conf="${my_conf} --enable-debug"

	./autogen.sh
	econf ${my_conf} || die
	emake || die
}

src_install() {
	einstall || die
}
