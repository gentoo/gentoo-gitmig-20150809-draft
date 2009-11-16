# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libemf/libemf-1.0.4.ebuild,v 1.2 2009/11/16 22:11:31 maekke Exp $

EAPI=2

inherit eutils

MY_P="${P/emf/EMF}"
DESCRIPTION="Library implementation of ECMA-234 API for the generation of enhanced metafiles."
HOMEPAGE="http://libemf.sourceforge.net/"
SRC_URI="mirror://sourceforge/libemf/${MY_P}.tar.gz"

LICENSE="LGPL-2.1 GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~ppc64 ~sparc x86"
IUSE="doc"

DEPEND=""

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${FILESDIR}"/${P}-amd64-alpha.patch
}

src_configure() {
	econf --enable-editing
}

src_install() {
	emake DESTDIR="${D}" install || die
	use doc && dohtml doc/html/*
	dodoc README NEWS AUTHORS ChangeLog
}
