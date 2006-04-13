# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libemf/libemf-1.0.3.ebuild,v 1.5 2006/04/13 19:25:03 chutzpah Exp $

inherit eutils

MY_P="${P/emf/EMF}"
DESCRIPTION="Library implementation of ECMA-234 API for the generation of enhanced metafiles."
HOMEPAGE="http://libemf.sourceforge.net/"
SRC_URI="mirror://sourceforge/pstoedit/${MY_P}.tar.gz"

LICENSE="LGPL-2.1 GPL-2"
SLOT="0"
KEYWORDS="~ppc ~ppc64 ~x86"
IUSE=""

DEPEND=""

S=${WORKDIR}/${MY_P}

src_compile() {
	econf --enable-editing || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dohtml doc/html/*
	dodoc README NEWS AUTHORS ChangeLog
}
