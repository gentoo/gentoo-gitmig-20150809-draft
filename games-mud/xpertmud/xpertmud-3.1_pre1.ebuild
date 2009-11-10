# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/xpertmud/xpertmud-3.1_pre1.ebuild,v 1.12 2009/11/10 21:03:24 ssuominen Exp $

EAPI=2
ARTS_REQUIRED=never
inherit eutils kde

MY_PV="${PV/_pre/preview}"
DESCRIPTION="the eXtensible Python pErl Ruby scripTable MUD client"
HOMEPAGE="http://xpertmud.sourceforge.net/"
SRC_URI="mirror://sourceforge/xpertmud/xpertmud-${MY_PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE="python ruby"

DEPEND=">=sys-devel/libperl-5.6.1
	python? ( >=dev-lang/python-2.2 )
	ruby? ( >=dev-lang/ruby-1.8.0 )"

need-kde 3.5

S=${WORKDIR}/xpertmud-${MY_PV}

src_prepare() {
	epatch "${FILESDIR}/${P}"-gcc34.patch \
		"${FILESDIR}/${P}"-gcc41.patch \
		"${FILESDIR}"/${P}-gcc43.patch
}

src_configure() {
	econf \
		--without-arts \
		$(use_with python python) \
		$(use_with ruby ruby) \
		--with-extra-includes=$(kde-config --expandvars --install include)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog DESIGN NEWS README TODO
}
