# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/gwhere/gwhere-0.1.1.ebuild,v 1.4 2004/06/24 22:21:59 agriffis Exp $

SRC_URI="http://www.gwhere.org/download/source/${P}.tar.gz"
HOMEPAGE="http://www.gwhere.org/"
DESCRIPTION="removable media cataloguer made with GTK+"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc ~sparc ~alpha"
IUSE="nls"

DEPEND=">=x11-libs/gtk+-1.2
	nls? ( sys-devel/gettext )"

src_compile() {
	econf `use_enable nls` || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	einstall || die "einstall failed"
	dodoc AUTHORS BUGS ChangeLog NEWS README TODO
}
