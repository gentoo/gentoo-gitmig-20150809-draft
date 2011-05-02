# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/mhonarc-gentoo/mhonarc-gentoo-2.6.18.ebuild,v 1.1 2011/05/02 22:21:32 tampakrap Exp $

inherit perl-app

IUSE=""

SRC_URI="http://www.mhonarc.org/release/MHonArc/tar/MHonArc-${PV}.tar.bz2"
RESTRICT="mirror"

DESCRIPTION="Perl Mail-to-HTML Converter, Gentoo fork"
HOMEPAGE="http://www.mhonarc.org/"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="!net-mail/mhonarc"

S="${WORKDIR}/${P/mhonarc-gentoo/MHonArc}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-archives-gentoo.patch
}

src_install() {
	sed -e "s|-prefix |-docpath '${D}/usr/share/doc/${PF}' -prefix '${D}'|g" -i Makefile
	sed -e "s|installsitelib|installvendorlib|g" -i install.me
	perl-module_src_install
	prepalldocs
}
