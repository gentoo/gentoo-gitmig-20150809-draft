# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-util/intltool/intltool-0.22.ebuild,v 1.1 2002/06/06 23:29:54 spider Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Scripts for extracting translatable strings from various sourcefiles"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"
SLOT="0"
LICENSE="GPL-2"


DEPEND="virtual/glibc
	>=dev-libs/popt-1.5
	>=sys-devel/perl-5.6.0"

RDEPEND=$DEPEND

src_compile() {                           
	econf || die "configure flawed" 
	emake || die "compile flawed" 
}

src_install() {
	einstall || die "installation failed"
	dodoc AUTHORS ChangeLog NEWS README
}

