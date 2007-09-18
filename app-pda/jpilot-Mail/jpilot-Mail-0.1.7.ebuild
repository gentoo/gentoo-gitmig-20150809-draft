# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/jpilot-Mail/jpilot-Mail-0.1.7.ebuild,v 1.1 2007/09/18 17:11:15 philantrop Exp $

inherit eutils multilib

DESCRIPTION="jpilot-Mail is a jpilot plugin to deliver mail from the pilot and upload mail to it."
SRC_URI="http://ludovic.rousseau.free.fr/softwares/jpilot-Mail/${P}.tar.gz"
HOMEPAGE="http://ludovic.rousseau.free.fr/softwares/jpilot-Mail/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=x11-libs/gtk+-2
		>=app-pda/jpilot-0.99.7-r1"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}/${P}.patch"
}

src_compile() {
	econf --enable-gtk2 || die "configure failed"
	emake -j1 || die "make failed"
}

src_install() {
	make install DESTDIR="${D}" \
		libdir=/usr/$(get_libdir)/jpilot/plugins \
		|| die "install failed"
}
