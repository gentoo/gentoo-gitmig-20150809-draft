# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/sumika/sumika-0.12.ebuild,v 1.6 2004/11/22 13:04:34 usata Exp $

DESCRIPTION="management utility for dictionaries of Anthy, SKK, Canna and PRIME"
HOMEPAGE="http://sumika.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/${PN}/9450/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE="nls"

DEPEND="virtual/libc
	>=x11-libs/gtk+-2.2
	>=dev-libs/glib-2.2
	dev-libs/gdome2
	nls? ( sys-devel/gettext )"

src_compile() {
	econf $(use_enable nls) || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	# we have our own place for docs
	dodir /usr/share/doc
	mv ${D}/usr/doc/${PN} ${D}/usr/share/doc/${PF}
}
