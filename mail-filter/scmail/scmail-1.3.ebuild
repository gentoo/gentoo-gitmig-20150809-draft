# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/scmail/scmail-1.3.ebuild,v 1.5 2009/08/16 07:17:05 hattya Exp $

inherit fixheadtails

IUSE=""

HOMEPAGE="http://0xcc.net/scmail/"
DESCRIPTION="a mail filter written in Scheme"
SRC_URI="http://0xcc.net/scmail/${P}.tar.gz"

LICENSE="BSD"
KEYWORDS="x86 ~ppc"
SLOT="0"

DEPEND=">=dev-scheme/gauche-0.7.4.1"

src_unpack() {

	unpack ${A}
	cd "${S}"

	ht_fix_file tests/scmail-commands

}

src_install() {

	emake \
		PREFIX="${D}/usr" \
		SITELIBDIR="${D}$(gauche-config --sitelibdir)" \
		DATADIR="${D}/usr/share/doc/${P}" \
		install \
		|| die

	dohtml doc/*.html

}
