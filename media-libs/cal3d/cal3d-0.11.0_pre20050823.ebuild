# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/cal3d/cal3d-0.11.0_pre20050823.ebuild,v 1.1 2005/08/31 19:12:05 malverian Exp $

inherit debug

DESCRIPTION="Cal3D is a skeletal based character animation library"
HOMEPAGE="http://cal3d.sourceforge.net/"
SRC_URI="mirror://sourceforge/cal3d/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc"
IUSE="${IUSE}"

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
