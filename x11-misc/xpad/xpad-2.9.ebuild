# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xpad/xpad-2.9.ebuild,v 1.1 2005/08/26 00:12:20 ferdy Exp $

DESCRIPTION="A GTK+ 2.0 based 'post-it' note system."
HOMEPAGE="http://xpad.sourceforge.net/"
SRC_URI="mirror://sourceforge/xpad/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.6.0"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.31
	sys-devel/gettext"

src_install () {
	einstall || die
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
}
