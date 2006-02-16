# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/acpitool/acpitool-0.4.4.ebuild,v 1.1 2006/02/16 15:06:00 sekretarz Exp $

inherit libtool eutils

DESCRIPTION="A small command line application, intended to be a replacement for the apm tool"
HOMEPAGE="http://freeunix.dyndns.org:8088/site2/acpitool.shtml"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND=""

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog README TODO
}
