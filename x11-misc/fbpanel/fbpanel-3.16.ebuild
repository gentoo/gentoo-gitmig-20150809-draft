# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/fbpanel/fbpanel-3.16.ebuild,v 1.1 2004/11/07 19:59:32 pyrania Exp $

DESCRIPTION="fbpanel is a light-weight X11 desktop panel"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"
HOMEPAGE="http://fbpanel.sourceforge.net/"
IUSE=""

SLOT="0"
KEYWORDS="~x86 ~amd64 ~alpha ~ppc"
LICENSE="as-is"
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
