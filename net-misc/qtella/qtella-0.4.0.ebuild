# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/qtella/qtella-0.4.0.ebuild,v 1.3 2002/04/13 16:43:44 danarmak Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-base || die

need-kde 2.2

SRC_URI="http://prdownloads.sourceforge.net/qtella/${P}.tar.gz"
HOMEPAGE="http://www.qtella.net"
DESCRIPTION="Excellent KDE Gnutella Client"

src_compile() {

	cd ${S}
	kde_src_compile myconf
	./configure ${myconf} --with-kde-libs=${KDE2DIR}/lib --with-kde-includes=${KDE2DIR}/include --prefix=/usr || die
	emake || die

}


