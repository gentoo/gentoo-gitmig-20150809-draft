# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome2-user-docs/gnome2-user-docs-1.93.ebuild,v 1.2 2002/07/11 06:30:26 drobbins Exp $


DESCRIPTION="end user documentation for Gnome2 "
HOMEPAGE="http://www.gnome.org"
LICENSE="FDL-1.1"
DEPEND="virtual/glibc
	>=app-text/docbook-sgml-utils-0.6.9
	>=app-text/scrollkeeper-0.2.0"
RDEPEND=$DEPEND
SRC_URI="ftp://ftp.gnome.org/pub/gnome/pre-gnome2/sources/${PN}/${P}.tar.bz2"
S=${WORKDIR}/${P}

src_compile() { 
	econf
	emake || die
}

src_install () {
	einstall
}
