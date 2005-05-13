# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dvenv/dvenv-0.2.2-r1.ebuild,v 1.2 2005/05/13 11:44:52 ka0ttic Exp $

inherit eutils

DESCRIPTION="dvenv provides polymorphic tree-structured environments, generalizing the Dv::Util::Props class"
HOMEPAGE="http://tinf2.vub.ac.be/~dvermeir/software/dv/dvenv/html/"
SRC_URI="http://tinf2.vub.ac.be/~dvermeir/software/dv/dvenv/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="doc"

DEPEND="dev-libs/dvutil"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-virtual-dtors.diff
	sed -i 's/^\(SUBDIRS =.*\)doc\(.*\)$/\1\2/' Makefile.in || \
		die "sed Makefile.in failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog README
	use doc && dohtml -r doc/html/*
}
