# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/sqsh/sqsh-2.1.3.ebuild,v 1.2 2005/04/07 04:05:55 mr_bones_ Exp $

inherit eutils

DESCRIPTION="Replacement for the venerable 'isql' program supplied by Sybase."
HOMEPAGE="http://sourceforge.net/projects/sqsh/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE="readline X motif"
KEYWORDS="~x86 ~amd64"

DEPEND="dev-db/freetds
	readline? ( sys-libs/readline )
	X? ( virtual/x11 )
	motif? ( x11-libs/openmotif )
	virtual/libc"

src_compile() {
	export SYBASE=/usr

	local myconf

	use motif && myconf="--with-motif"

	econf \
		$(use_with readline) \
		$(use_with X x) \
		${myconf} || die

	emake \
		SQSHRC_GLOBAL=/etc/sqshrc || die
}

src_install () {
	einstall \
		SQSHRC_GLOBAL=${D}/etc/sqshrc || die

	make man_dir=${D}/usr/share/man install.man || die
	dodoc INSTALL README doc/*
}
