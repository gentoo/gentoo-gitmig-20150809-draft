# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/fbpanel/fbpanel-3.8-r1.ebuild,v 1.5 2004/09/02 22:49:40 pvdabeel Exp $

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

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i config/default.cfg -e \
		's,\(^[ \t]\+Show\(Iconified\|Mapped\|AllDesks\)\),### \1,' \
		|| die "sed magic failed. Call an ambulance."
}

src_compile() {
	# econf not happy here
	./configure --prefix=/usr || die "Configure failed."
	emake || die "Make failed."
}

src_install () {
	emake install PREFIX=${D}/usr || die
	dodoc README CREDITS COPYING CHANGELOG
}
