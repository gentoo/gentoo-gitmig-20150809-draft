# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/coldsync/coldsync-2.2.5-r1.ebuild,v 1.9 2007/06/26 01:41:10 mr_bones_ Exp $

inherit eutils

DESCRIPTION="A command-line tool to synchronize PalmOS PDAs with Unix workstations"
SRC_URI="http://www.coldsync.org/download/${P}.tar.gz"
HOMEPAGE="http://www.coldsync.org/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~ppc sparc x86"
IUSE="nls perl"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch ${FILESDIR}/coldsync-2.2.5-gcc3.diff
	epatch ${FILESDIR}/coldsync-2.2.5-broken-c++.diff
}

src_compile() {
	cd ${S}
	econf $(use_with nls i18n) $(use_with perl)
	make || die "couldn't make coldsync"
}

src_install() {
	make \
		PREFIX=${D}/usr \
		MANDIR=${D}/usr/share/man \
		SYSCONFDIR=${D}/etc \
		DATADIR=${D}/usr/share \
		INFODIR=${D}/usr/share/info \
		INSTALLMAN3DIR=${D}/usr/share/man/man3 \
		INSTALLSITEMAN3DIR=${D}/usr/share/man/man3 \
		INSTALLVENDORMAN3DIR=${D}/usr/share/man/man3 \
		install || die "couldn't install coldsync"

	dodoc AUTHORS Artistic ChangeLog HACKING INSTALL NEWS README TODO
}
