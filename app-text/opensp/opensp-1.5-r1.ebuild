# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/opensp/opensp-1.5-r1.ebuild,v 1.1 2003/05/07 20:38:49 liquidx Exp $

MY_P=${P/opensp/OpenSP}
S=${WORKDIR}/${MY_P}
DESCRIPTION="A free, object-oriented toolkit for SGML parsing and entity management"
HOMEPAGE="http://openjade.sourceforge.net/"
SRC_URI="mirror://sourceforge/openjade/${MY_P}.tar.gz"
LICENSE="as-is"

SLOT="0"
KEYWORDS="~x86"
IUSE="nls"
DEPEND="nls? ( sys-devel/gettext )"
PDEPEND=">=app-text/openjade-1.3.2"

# Note: openjade is in PDEPEND because starting from openjade-1.3.2, opensp
#       has been SPLIT from openjade into its own package. Hence if you
#       install this, you need to upgrade to a new openjade as well.

src_compile() {
	local myconf
	
	myconf="${myconf} --enable-default-catalog=/etc/sgml/catalog"
	myconf="${myconf} --enable-default-search-path=/usr/share/sgml"
	myconf="${myconf} --datadir=/usr/share/sgml/${P}"
	econf ${myconf}
	emake pkgdocdir=/usr/share/doc/${PF} || die "parallel make failed"
}

src_install() {
	make DESTDIR=${D} pkgdocdir=/usr/share/doc/${PF} install || die
}
