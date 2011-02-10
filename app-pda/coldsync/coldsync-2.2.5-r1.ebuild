# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/coldsync/coldsync-2.2.5-r1.ebuild,v 1.10 2011/02/10 15:06:25 ssuominen Exp $

EAPI=2
inherit eutils

DESCRIPTION="A command-line tool to synchronize PalmOS PDAs with Unix workstations"
HOMEPAGE="http://www.coldsync.org/"
SRC_URI="http://www.coldsync.org/download/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~ppc sparc x86"
IUSE="nls perl"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-2.2.5-gcc3.diff \
		"${FILESDIR}"/${PN}-2.2.5-broken-c++.diff
}

src_configure() {
	econf \
		$(use_with nls i18n) \
		$(use_with perl)
}

src_install() {
	emake \
		PREFIX="${D}"/usr \
		MANDIR="${D}"/usr/share/man \
		SYSCONFDIR="${D}"/etc \
		DATADIR="${D}"/usr/share \
		INFODIR="${D}"/usr/share/info \
		INSTALLMAN3DIR="${D}"/usr/share/man/man3 \
		INSTALLSITEMAN3DIR="${D}"/usr/share/man/man3 \
		INSTALLVENDORMAN3DIR="${D}"/usr/share/man/man3 \
		install || die

	dodoc AUTHORS ChangeLog HACKING NEWS README TODO
}
