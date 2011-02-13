# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/mhonarc/mhonarc-2.6.16-r1.ebuild,v 1.4 2011/02/13 11:21:04 kumba Exp $

inherit perl-app

IUSE=""

SRC_URI="http://www.mhonarc.org/release/MHonArc/tar/MHonArc-${PV}.tar.bz2"
RESTRICT="mirror"

DESCRIPTION="Perl Mail-to-HTML Converter"
HOMEPAGE="http://www.mhonarc.org/"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~alpha amd64 ~mips ~ppc ~sparc x86"

S="${WORKDIR}/${P/mhonarc/MHonArc}"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${P}-list-output-order.patch
}

src_install() {
	sed -e "s|-prefix |-prefix ${D}|g" -i Makefile
	perl-module_src_install
}
