# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/manpages-ru/manpages-ru-0.7.ebuild,v 1.15 2005/01/01 14:35:45 eradicator Exp $

inherit eutils

DESCRIPTION="A collection of Russian translations of Linux manual pages."
HOMEPAGE="http://alexm.here.ru/manpages-ru/"
SRC_URI="ftp://ftp.win.tue.nl/pub/linux-local/manpages/translations/man-pages-ru-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="x86 ppc hppa"

DEPEND=""
RDEPEND="sys-apps/man"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-gentoo.diff
}

src_compile() {
	make || die
}

src_install() {
	make INSTALLPATH=${D}/usr/share/man LANG_SUBDIR=ru install || die
	prepallman
}
