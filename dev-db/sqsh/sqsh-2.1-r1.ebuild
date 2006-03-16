# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/sqsh/sqsh-2.1-r1.ebuild,v 1.13 2006/03/16 13:51:28 caleb Exp $

inherit eutils

DESCRIPTION="Replacement for the venerable 'isql' program supplied by Sybase."
HOMEPAGE="http://www.sqsh.org/"
SRC_URI="http://www.sqsh.org/${P}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE="readline X motif"
KEYWORDS="x86 amd64"

DEPEND="dev-db/freetds
	readline? ( sys-libs/readline )
	X? ( || ( (
		x11-libs/libXaw
		x11-libs/libXt
		x11-libs/libXext
		x11-libs/libXmu
		x11-libs/libX11 )
	virtual/x11 ) )
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


	emake SQSHRC_GLOBAL=/etc/sqshrc || die
}

src_install () {
	einstall SQSHRC_GLOBAL=${D}/etc/sqshrc || die
	make man_dir=${D}/usr/share/man install.man || die
	dodoc COPYING INSTALL README doc/*
}
