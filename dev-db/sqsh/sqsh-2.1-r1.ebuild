# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/sqsh/sqsh-2.1-r1.ebuild,v 1.10 2005/04/06 20:50:37 seemant Exp $

inherit eutils

DESCRIPTION="Replacement for the venerable 'isql' program supplied by Sybase."
HOMEPAGE="http://www.sqsh.org/"
SRC_URI="http://www.sqsh.org/${P}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE="readline X motif"
KEYWORDS="x86 ~amd64"

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


	emake SQSHRC_GLOBAL=/etc/sqshrc || die
}

src_install () {
	make \
		DESTDIR=${D} \
		RPM_BUILD_ROOT=${D} \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install install.man || die
	# fix the silly placement of sqshrc
	dodir /etc
	mv ${D}/usr/etc/sqshrc ${D}/etc/
	rmdir ${D}/usr/etc
	dodoc COPYING INSTALL README doc/*
}
