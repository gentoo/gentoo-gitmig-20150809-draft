# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/urlview/urlview-0.9.ebuild,v 1.17 2004/07/14 06:41:08 mr_bones_ Exp $

inherit eutils

DESCRIPTION="extracts urls from text and will send them to another app"
HOMEPAGE="http://www.mutt.org"
SRC_URI="ftp://gd.tuwien.ac.at/infosys/mail/mutt/contrib/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha s390"
IUSE=""

DEPEND=">=sys-libs/ncurses-5.2"

src_compile() {
	epatch ${FILESDIR}/no-trailing-newline.patch

	./configure \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--prefix=/usr \
		--sysconfdir=/etc \
		--host=${CHOST} || die "Configure Failed"

	 emake || die "Parallel Make Failed"
}

src_install () {
	dodir /usr/share/man/man1

	make infodir=${D}/usr/share/info \
		mandir=${D}/usr/share/man \
		prefix=${D}/usr \
		sysconfdir=${D}/etc \
		install || die "Installation Failed"

	dodoc README INSTALL ChangeLog AUTHORS COPYING sample.urlview
	dobin url_handler.sh
}

pkg_postinst() {
	einfo "There is a sample.urlview in /usr/share/doc/${P}"
	einfo "You can also customize /usr/bin/url_handler.sh"
}

