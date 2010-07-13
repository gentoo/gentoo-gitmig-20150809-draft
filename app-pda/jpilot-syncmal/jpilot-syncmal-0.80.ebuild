# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/jpilot-syncmal/jpilot-syncmal-0.80.ebuild,v 1.4 2010/07/13 14:05:40 ssuominen Exp $

WANT_AUTOMAKE="1.9"

inherit multilib autotools

DESCRIPTION="Syncmal plugin for jpilot"
SRC_URI="mirror://gentoo/${P}.tar.gz"
HOMEPAGE="http://www.jlogday.com/code/syncmal/index.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=app-pda/jpilot-0.99.9"
DEPEND="${RDEPEND}
		>=app-pda/pilot-link-0.12.2
		>=x11-libs/gtk+-2.6.10-r1
		>=dev-libs/libmal-0.44"

src_unpack() {
	unpack ${A}
	sed -i -e "s:/lib/jpilot/plugins:/$(get_libdir)/jpilot/plugins:" \
		"${S}/Makefile.am" || die "sed'ing Makefile.am failed"

	cd "${S}"
	eautomake
}

src_compile() {
	econf || die "configure failed"
	emake -j1 || die "make failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "installation failed"
}
