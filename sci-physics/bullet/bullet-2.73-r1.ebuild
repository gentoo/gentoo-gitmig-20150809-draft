# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-physics/bullet/bullet-2.73-r1.ebuild,v 1.1 2009/01/06 11:35:21 bicatali Exp $

inherit eutils autotools

MYP="${P}-sp1"

DESCRIPTION="Continuous Collision Detection and Physics Library"
HOMEPAGE="http://www.continuousphysics.com/Bullet/"
SRC_URI="http://bullet.googlecode.com/files/${MYP}.tgz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples"

RDEPEND=""
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# clean up
	rm -rf Extras/LibXML
	rm -f Extras/CDTestFramework/AntTweakBar/lib/libAntTweakBar.so

	epatch "${FILESDIR}"/${P}-autotools.patch
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README ChangeLog AUTHORS || die

	if use doc; then
		insinto /usr/share/doc/${PF}
		doins *.pdf || die
	fi
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r Extras Demos || die
	fi
}
