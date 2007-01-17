# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/docbook2X/docbook2X-0.8.7.ebuild,v 1.1 2007/01/17 21:08:23 antarus Exp $

DESCRIPTION="Tools to convert docbook to man and info"
SRC_URI="mirror://sourceforge/docbook2x/${P}.tar.gz"
HOMEPAGE="http://docbook2x.sourceforge.net"

SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"
IUSE=""
LICENSE="GPL-2"

DEPEND=""

RDEPEND=">=dev-perl/XML-Writer-0.4
	>=dev-perl/XML-XSLT-0.31
	>=dev-perl/SGMLSpm-1.03
	dev-libs/libxslt"

src_compile () {
	cd "${S}"
	econf \
		--with-xslt-processor=libxslt \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install () {
	make DESTDIR=${D} install || die "install failed"
}
