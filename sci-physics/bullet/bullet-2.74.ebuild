# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-physics/bullet/bullet-2.74.ebuild,v 1.2 2009/06/24 04:59:04 bicatali Exp $

EAPI=2
inherit eutils autotools

DESCRIPTION="Continuous Collision Detection and Physics Library"
HOMEPAGE="http://www.continuousphysics.com/Bullet/"
SRC_URI="http://bullet.googlecode.com/files/${P}.tgz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples threads"

RDEPEND=""
DEPEND="${RDEPEND}"

src_prepare() {
	rm -rf Extras/LibXML
	rm -f Extras/CDTestFramework/AntTweakBar/lib/libAntTweakBar.so
	epatch "${FILESDIR}"/${P}-noextra.patch
	epatch "${FILESDIR}"/${P}-missing-header.patch
	eautoreconf
	edos2unix install-sh || die
}
src_configure() {
	econf \
		--disable-demos \
		$(use_enable threads multithreaded)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README ChangeLog AUTHORS || die
	if use doc; then
		insinto /usr/share/doc/${PF}
		doins *.pdf || die
	fi
	if use examples; then
		emake distclean
		insinto /usr/share/doc/${PF}/examples
		doins -r Extras Demos || die
	fi
}
