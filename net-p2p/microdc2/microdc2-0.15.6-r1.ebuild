# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/microdc2/microdc2-0.15.6-r1.ebuild,v 1.1 2009/11/08 19:30:29 armin76 Exp $

inherit eutils

DESCRIPTION="A small command-line based Direct Connect client"
HOMEPAGE="http://corsair626.no-ip.org/microdc/"
SRC_URI="http://corsair626.no-ip.org/microdc/${P}.tar.gz
	mirror://gentoo/${P}-patches-0.1.tar.bz2
	http://dev.gentoo.org/~armin76/dist/${P}-patches-0.1.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls"

DEPEND=">=dev-libs/libxml2-2.6.16
	sys-libs/ncurses
	>=sys-libs/readline-4
	nls? ( sys-devel/gettext )"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	EPATCH_SOURCE="${WORKDIR}/patch" EPATCH_SUFFIX="patch" \
		EPATCH_FORCE="yes" epatch
}

src_compile() {
	econf $(use_enable nls) || die "econf failed"
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README doc/*
}
