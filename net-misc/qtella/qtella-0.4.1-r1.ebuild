# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/qtella/qtella-0.4.1-r1.ebuild,v 1.2 2002/03/13 20:26:27 danarmak Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-base || die

need-kde 3

S=${WORKDIR}/${P}b
SRC_URI="http://prdownloads.sourceforge.net/qtella/${P}b.tar.gz"
HOMEPAGE="http://www.qtella.net"
DESCRIPTION="Excellent KDE Gnutella Client"
SLOT="0"

src_compile() {

	cd ${S}
	kde_src_compile myconf
	./configure ${myconf} --with-kde-libs=${KDE3DIR}/lib --with-kde-includes=${KDE3DIR}/include --prefix=/usr || die
	emake || die

}


