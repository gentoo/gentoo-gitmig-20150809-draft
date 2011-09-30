# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nntp/slrn/slrn-1.0.0_pre18.ebuild,v 1.2 2011/09/30 10:28:12 radhermit Exp $

EAPI=4
inherit eutils

MY_P="${PN}-pre${PV/_pre/~}"

DESCRIPTION="A s-lang based newsreader"
HOMEPAGE="http://slrn.sourceforge.net/"
SRC_URI="http://slrn.sourceforge.net/downloads/svn_snapshots/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="canlock nls ssl uudeview"

RDEPEND="virtual/mta
	app-arch/sharutils
	>=sys-libs/slang-2.1.3
	canlock? ( net-libs/canlock )
	ssl? ( dev-libs/openssl )
	uudeview? ( dev-libs/uulib )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

S=${WORKDIR}/${PN}

src_prepare() {
	epatch "${FILESDIR}"/${P}-make.patch
}

src_configure() {
	econf \
		--with-docdir="${EPREFIX}"/usr/share/doc/${PF} \
		--with-slrnpull \
		$(use_with canlock) \
		$(use_with uudeview uu) \
		$(use_enable nls) \
		$(use_with ssl)
}
