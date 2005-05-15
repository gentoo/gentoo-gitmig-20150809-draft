# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/esms/esms-0.9.5.ebuild,v 1.1 2005/05/15 19:06:59 mrness Exp $

DESCRIPTION="A small console program to send SMS messages to Spanish cellular phones"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://esms.sourceforge.net"
KEYWORDS="x86 sparc ppc"
IUSE=""
LICENSE="GPL-2"
SLOT="0"

DEPEND=">=dev-perl/libwww-perl-5.64 \
	>=dev-perl/HTML-Parser-3.26 \
	>=dev-perl/HTML-Tree-3.11
	>=dev-lang/perl-5.6.1"


src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install () {
	make DESTDIR=${D} install || die "install failed"
}
