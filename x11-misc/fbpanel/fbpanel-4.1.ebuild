# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/fbpanel/fbpanel-4.1.ebuild,v 1.2 2005/02/08 12:43:48 ka0ttic Exp $

DESCRIPTION="fbpanel is a light-weight X11 desktop panel"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"
HOMEPAGE="http://fbpanel.sourceforge.net/"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ~amd64 ~alpha ~ppc"
IUSE=""

DEPEND=">=x11-libs/gtk+-2
	>=sys-apps/sed-4"
RDEPEND=">=x11-libs/gtk+-2"

src_compile() {
	# econf not happy here
	./configure --prefix=/usr || die "Configure failed."
	emake || die "Make failed."
}

src_install () {
	emake install PREFIX=${D}/usr || die
	dodoc README CREDITS COPYING CHANGELOG
}
