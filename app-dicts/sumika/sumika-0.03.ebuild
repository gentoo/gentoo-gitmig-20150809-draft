# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/sumika/sumika-0.03.ebuild,v 1.2 2003/11/14 11:13:26 usata Exp $

IUSE="nls"

DESCRIPTION="Sumika is a management utility for dictionaries of Anthy, SKK, Canna and PRIME"
HOMEPAGE="http://sumika.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/${PN}/6250/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"

S="${WORKDIR}/${P}"

DEPEND="virtual/glibc
	>=x11-libs/gtk+-2.2
	>=dev-libs/glib-2.2
	nls? ( sys-devel/gettext )"

src_compile() {

	econf `use_enable nls` || die
	emake || die
}

src_install() {

	einstall || die

	# we have our own place for docs
	dodir /usr/share/doc
	mv ${D}/usr/doc/${PN} ${D}/usr/share/doc/${PF}
}
