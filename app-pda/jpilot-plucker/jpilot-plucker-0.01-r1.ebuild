# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/jpilot-plucker/jpilot-plucker-0.01-r1.ebuild,v 1.2 2008/10/04 18:42:08 mabi Exp $

inherit eutils multilib

DESCRIPTION="Plucker plugin for jpilot"
SRC_URI="http://jasonday.home.att.net/code/jpilot-plucker/${P}.tar.gz"
HOMEPAGE="http://jasonday.home.att.net/code/jpilot-plucker/jpilot-plucker.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.6.10-r1
		>=app-pda/pilot-link-0.11.8
		>=app-pda/jpilot-0.99.7-r1"
DEPEND="${RDEPEND}
		dev-util/pkgconfig"

src_unpack() {
	unpack ${A}

	cd "${S}"
	# Fixes bug 193260.
	epatch "${FILESDIR}/${P}-pilot-0.12-compat.patch"
}

src_compile() {
	econf --enable-gtk2 || die "configure failed"
	emake -j1 || die "make failed"
}

src_install() {
	emake install DESTDIR="${D}" \
		libdir=/usr/$(get_libdir)/jpilot/plugins \
		|| die "install failed"
}
