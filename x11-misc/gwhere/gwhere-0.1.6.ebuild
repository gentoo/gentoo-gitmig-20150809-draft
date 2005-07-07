# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/gwhere/gwhere-0.1.6.ebuild,v 1.2 2005/07/07 11:55:54 agriffis Exp $

DESCRIPTION="Removable media cataloger made with GTK+"
HOMEPAGE="http://www.gwhere.org/"
SRC_URI="http://www.gwhere.org/download/source/${P}.tar.gz"

KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
LICENSE="GPL-2"
SLOT="0"

IUSE="gtk gtk2 nls"

DEPEND="!gtk2? ( >=x11-libs/gtk+-1.2 )
	gtk2? ( >=x11-libs/gtk+-2 )
		nls? ( sys-devel/gettext )"

src_compile() {
	econf `use_enable nls` \
		      `use_enable gtk gtk20` || die
	emake || die "emake failed"
}

src_install() {
	einstall || die
	dodoc AUTHORS BUGS ChangeLog NEWS README TODO || die "dodoc failed"
}
