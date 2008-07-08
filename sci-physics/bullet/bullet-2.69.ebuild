# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-physics/bullet/bullet-2.69.ebuild,v 1.1 2008/07/08 14:23:22 bicatali Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Continuous Collision Detection and Physics Library"
HOMEPAGE="http://www.continuousphysics.com/Bullet/"
SRC_URI="http://bullet.googlecode.com/files/${P}.tgz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc examples"

RDEPEND="examples? ( virtual/opengl virtual/glut )"
DEPEND="${DEPEND}
	dev-util/ftjam"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e 's:-O3 -fomit-frame-pointer -ffast-math::' \
		Jamrules || die "sed Jamrules failed"
}

src_compile() {
	econf \
		$(use_with examples x) \
		$(use_with examples mesa) \
		|| die "econf failed"
	jam -qa || die "jam failed"
}

src_test() {
	jam check || die "jam check failed"
}

src_install() {
	jam -sDESTDIR="${D}" install || die "jam install failed"
	dodoc README ChangeLog.txt AUTHORS || die
	if use doc; then
		insinto /usr/share/doc/${PF}
		doins *.pdf || die
	fi
}
