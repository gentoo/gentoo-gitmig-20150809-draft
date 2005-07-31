# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/acpitool/acpitool-0.2.7.ebuild,v 1.1 2005/07/31 10:04:37 sekretarz Exp $

inherit libtool eutils

DESCRIPTION="A small command line application, intended to be a replacement for the apm tool"
HOMEPAGE="http://freeunix.dyndns.org:8088/site2/acpitool.shtml"
SRC_URI="http://freeunix.dyndns.org:8088/ftp_site/pub/unix/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND=""

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-gentoo.patch
	autoreconf
}

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog README TODO
}
