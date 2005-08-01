# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xpad/xpad-2.8.ebuild,v 1.3 2005/08/01 18:13:16 gustavoz Exp $

DESCRIPTION="A GTK+ 2.0 based 'post-it' note system."
HOMEPAGE="http://xpad.sourceforge.net/"
SRC_URI="mirror://sourceforge/xpad/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 ~ppc sparc x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.6.0"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.31
	sys-devel/gettext"

src_install () {
	einstall || die
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
}
