# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/opensp/opensp-1.5.1.ebuild,v 1.5 2005/03/20 19:17:22 weeve Exp $

inherit eutils

MY_P=${P/opensp/OpenSP}
S=${WORKDIR}/${MY_P}
DESCRIPTION="A free, object-oriented toolkit for SGML parsing and entity management"
HOMEPAGE="http://openjade.sourceforge.net/"
SRC_URI="mirror://sourceforge/openjade/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha ~amd64 arm hppa ia64 ~mips ~ppc ~ppc64 s390 sparc x86"
IUSE="nls"

DEPEND="nls? ( sys-devel/gettext )"
PDEPEND=">=app-text/openjade-1.3.2"

# Note: openjade is in PDEPEND because starting from openjade-1.3.2, opensp
#       has been SPLIT from openjade into its own package. Hence if you
#       install this, you need to upgrade to a new openjade as well.

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-1.5-gcc34.patch
}

src_compile() {
	local myconf
	myconf="${myconf} --enable-http"
	myconf="${myconf} --enable-default-catalog=/etc/sgml/catalog"
	myconf="${myconf} --enable-default-search-path=/usr/share/sgml"
	myconf="${myconf} --datadir=/usr/share/sgml/${P}"
	econf ${myconf} $(use_enable nls) || die "econf failed"
	emake pkgdocdir=/usr/share/doc/${PF} || die "parallel make failed"
}

src_install() {
	make DESTDIR="${D}" pkgdocdir=/usr/share/doc/${PF} install || die
}
