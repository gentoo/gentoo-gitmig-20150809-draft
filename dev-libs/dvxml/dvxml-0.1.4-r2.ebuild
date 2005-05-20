# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dvxml/dvxml-0.1.4-r2.ebuild,v 1.1 2005/05/20 12:58:41 ka0ttic Exp $

inherit eutils

DESCRIPTION="dvxml provides some convenient stuff on top of the xmlwrapp package"
SRC_URI="http://tinf2.vub.ac.be/~dvermeir/software/dv/dvxml/download/dvxml-${PV}.tar.gz"
HOMEPAGE="http://tinf2.vub.ac.be/~dvermeir/software/dv/dvxml/html/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="doc"

DEPEND="dev-libs/dvutil
	dev-libs/xmlwrapp"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-fix-underquoted-m4.diff

	sed -i 's/^\(SUBDIRS =.*\)doc\(.*\)$/\1\2/' Makefile.in || \
		die "sed Makefile.in failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc ChangeLog README AUTHORS
	use doc && dohtml -r doc/html/*
}
