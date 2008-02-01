# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dvticket/dvticket-0.7.6.ebuild,v 1.1 2008/02/01 04:51:01 halcy0n Exp $

S=${WORKDIR}/dvticket-${PV}
DESCRIPTION="dvticket provides a framework for a ticket server"
SRC_URI="http://tinf2.vub.ac.be/~dvermeir/software/dv/dvticket/download/dvticket-${PV}.tar.gz"
HOMEPAGE="http://tinf2.vub.ac.be/~dvermeir/software/dv/dvticket/html/"
KEYWORDS="~amd64 ~ppc ~x86"
LICENSE="GPL-2"
SLOT="0"

IUSE="doc"
DEPEND="dev-libs/dvutil
	dev-libs/dvnet
	dev-libs/dvcgi
	dev-libs/dvxml
	dev-libs/dvssl
	dev-libs/dvmysql"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i 's|^\(SUBDIRS =.*\)doc\(.*\)$|\1\2|' Makefile.in || \
	die "sed Makefile.in failed"
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog NEWS README

	if use doc ; then
		doman doc/man/*/*.[1-9]
		dohtml -r doc/html/*
	fi
}
