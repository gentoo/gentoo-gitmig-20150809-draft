# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Geert Bevin <gbevin@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/fidelio/fidelio-0.9.6-r1.ebuild,v 1.2 2002/05/23 06:50:17 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Fidelio is a Linux/Unix client for Hotline, a proprietary protocol that combines ftp-like, irc-like and news-like functions with user authentication and permissions in one package."
SRC_URI="http://download.sourceforge.net/fidelio/${PN}-${PV}.tar.gz"
HOMEPAGE="http://fidelio.sourceforge.net/"

DEPEND="virtual/glibc
	virtual/x11
	=x11-libs/gtk+-1.2*
	>=gnome-base/gnome-libs-1.4.1.2
	>=dev-libs/libxml2-2.4.12
	esd? ( >=media-sound/esound-0.2.23 )"

src_compile() {
	
	CFLAGS="${CFLAGS} -I/usr/include/libxml2/libxml"
	CXXFLAGS="${CXXFLAGS} -I/usr/include/libxml2/libxml"
	export CPPFLAGS="-I/usr/include/libxml2"
	export XML_CONFIG="/usr/bin/xml2-config"
	econf || die
	emake || die

}

src_install () {

	einstall || die

}

