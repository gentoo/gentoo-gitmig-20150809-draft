# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/wpd2sxw/wpd2sxw-0.6.0-r1.ebuild,v 1.1 2004/06/11 22:14:24 squinky86 Exp $

DESCRIPTION="WordPerfect Document (wpd) to OpenOffice.org (sxw) converter"
HOMEPAGE="http://libwpd.sf.net"
SRC_URI="mirror://sourceforge/libwpd/${P}.tar.gz
	perl? ( http://libwpd.sourceforge.net/wpd2sxwbatch.pl )"
RESTRICT="nomirror"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="perl"
DEPEND="gnome-extra/libgsf
	>=app-text/libwpd-0.7.1
	perl? ( dev-lang/perl )"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}
}

src_compile() {
	econf || die "configure failed"
	emake || die "make failed"
}

src_install() {
	einstall || die "install failed"
	dobin ${DISTDIR}/wpd2sxwbatch.pl
}
