# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/hspell/hspell-1.0.ebuild,v 1.1 2006/09/03 07:48:22 genstef Exp $

inherit eutils

DESCRIPTION="A Hebrew spell checker"
HOMEPAGE="http://www.ivrix.org.il/projects/spell-checker/"
SRC_URI="http://ivrix.org.il/projects/spell-checker/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~ppc ~x86"
IUSE=""

DEPEND=">=dev-lang/perl-5.6.1"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd ${S}
	# remove stripping
	sed -i -e "s:.*strip.*::" Makefile.in
}

src_compile() {
	econf \
		--enable-linginfo \
		--enable-fatverb \
		|| die "econf failed"
	emake -j1 || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README TODO WHATSNEW
}
