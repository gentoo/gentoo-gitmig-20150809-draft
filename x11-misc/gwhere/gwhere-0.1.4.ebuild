# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/gwhere/gwhere-0.1.4.ebuild,v 1.4 2005/09/17 02:00:56 agriffis Exp $

DESCRIPTION="Removable media cataloger made with GTK+"
HOMEPAGE="http://www.gwhere.org/"
SRC_URI="http://www.gwhere.org/download/source/${P}.tar.gz"

KEYWORDS="alpha ppc ~sparc x86"
LICENSE="GPL-2"
SLOT="0"

IUSE="nls"

DEPEND=">=x11-libs/gtk+-1.2
	nls? ( sys-devel/gettext )"

src_compile() {
	econf `use_enable nls` || die
	emake || die "emake failed"
}

src_install() {
	einstall || die
	dodoc AUTHORS BUGS ChangeLog NEWS README TODO || die "dodoc failed"
}
