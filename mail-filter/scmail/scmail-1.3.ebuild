# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/scmail/scmail-1.3.ebuild,v 1.6 2010/04/11 10:08:49 hattya Exp $

EAPI="2"

inherit eutils fixheadtails

IUSE=""

HOMEPAGE="http://0xcc.net/scmail/"
DESCRIPTION="a mail filter written in Scheme"
SRC_URI="http://0xcc.net/scmail/${P}.tar.gz"

LICENSE="BSD"
KEYWORDS="x86 ~ppc"
SLOT="0"

DEPEND="dev-scheme/gauche"

src_prepare() {

	epatch "${FILESDIR}"/${PN}-gauche-0.9.diff

	ht_fix_file tests/scmail-commands

	# replace make -> $(MAKE)
	sed -i "s/make\( \|$\)/\$(MAKE)\1/g" Makefile || die

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
