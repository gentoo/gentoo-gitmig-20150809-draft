# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/wpd2sxw/wpd2sxw-0.6.0-r1.ebuild,v 1.6 2005/12/11 10:48:06 suka Exp $

DESCRIPTION="WordPerfect Document (wpd) to OpenOffice.org (sxw) converter"
HOMEPAGE="http://libwpd.sf.net"
SRC_URI="mirror://sourceforge/libwpd/${P}.tar.gz
	perl? ( mirror://gentoo/wpd2sxwbatch.pl )"
RESTRICT="nomirror"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ppc"
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
