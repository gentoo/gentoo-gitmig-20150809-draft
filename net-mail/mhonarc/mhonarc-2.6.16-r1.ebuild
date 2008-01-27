# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/mhonarc/mhonarc-2.6.16-r1.ebuild,v 1.1 2008/01/27 06:05:16 kumba Exp $

inherit perl-app

IUSE=""

SRC_URI="http://www.mhonarc.org/release/MHonArc/tar/MHonArc-${PV}.tar.bz2"
RESTRICT="mirror"

DESCRIPTION="Perl Mail-to-HTML Converter"
HOMEPAGE="http://www.mhonarc.org/"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~mips ~amd64"

S="${WORKDIR}/${P/mhonarc/MHonArc}"

src_unpack() {
	unpack "${A}"
	epatch "${FILESDIR}"/${P}-list-output-order.patch
}

src_install() {
	sed -e "s|-prefix |-prefix ${D}|g" -i Makefile
	perl-module_src_install
}
