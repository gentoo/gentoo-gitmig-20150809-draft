# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/cal3d/cal3d-0.11.0_pre20050823.ebuild,v 1.7 2007/07/12 03:10:24 mr_bones_ Exp $

inherit eutils

DESCRIPTION="Cal3D is a skeletal based character animation library"
HOMEPAGE="http://cal3d.sourceforge.net/"
SRC_URI="mirror://sourceforge/cal3d/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86"
IUSE="debug"

RDEPEND=""
DEPEND=">=sys-devel/automake-1.4
	>=sys-devel/autoconf-2.13
	!<media-libs/cal3d-0.11"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-libtool-compat.patch"
}

src_compile() {
	use debug && my_conf="${my_conf} --enable-debug"

	./autogen.sh
	econf ${my_conf} || die
	emake || die
}

src_install() {
	einstall || die
}
