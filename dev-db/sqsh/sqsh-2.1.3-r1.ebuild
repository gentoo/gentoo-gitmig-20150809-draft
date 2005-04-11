# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/sqsh/sqsh-2.1.3-r1.ebuild,v 1.1 2005/04/11 18:59:29 seemant Exp $

inherit eutils

DESCRIPTION="Replacement for the venerable 'isql' program supplied by Sybase."
HOMEPAGE="http://sourceforge.net/projects/sqsh/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz
	mirror://gentoo/${P}-autotools.patch.bz2"

LICENSE="GPL-2"
SLOT="0"
IUSE="readline X motif"
KEYWORDS="~x86 ~amd64"

DEPEND="dev-db/freetds
	readline? ( sys-libs/readline )
	X? ( virtual/x11 )
	motif? ( x11-libs/openmotif )
	virtual/libc"

src_unpack() {
	unpack ${A}; cd ${S}
	epatch ${WORKDIR}/${P}-autotools.patch
}

src_compile() {
	export SYBASE=/usr

	local myconf

	econf \
		$(use_with readline) \
		$(use_with X x) \
		$(use_with motif) \
		${myconf} || die

	emake || die
}

src_install () {
	einstall install.man || die

	dodoc INSTALL README doc/*
}
