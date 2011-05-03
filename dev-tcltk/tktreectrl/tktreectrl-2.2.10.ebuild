# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tktreectrl/tktreectrl-2.2.10.ebuild,v 1.1 2011/05/03 20:06:11 jlec Exp $

EAPI=4

inherit eutils

DESCRIPTION="A flexible listbox widget for Tk"
HOMEPAGE="http://tktreectrl.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="tktreectrl"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE="X debug shellicon threads"

RDEPEND=">=dev-lang/tcl-8.4"
DEPEND="${REDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/2.2.9-as-needed.patch
}

src_configure() {
	econf \
	$(use_enable threads) \
	$(use_enable shellicon) \
	$(use_enable amd64 64bit) \
	$(use_enable debug symbols) \
	$(use_enable X x) \
	--enable-shared
}

#src_test() {
#	emake test || die
#}

src_install() {
	default
	mv "${ED}"/usr/lib*/treectrl${PV}/htmldoc "${ED}"/usr/share/doc/${P}/
}
