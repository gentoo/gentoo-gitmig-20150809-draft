# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmdrawer/wmdrawer-0.10.5-r1.ebuild,v 1.1 2005/03/29 13:51:30 s4t4n Exp $

inherit eutils

IUSE="gtk2"
DESCRIPTION="wmDrawer is a dock application (dockapp) which provides a drawer (retractable button bar) to launch applications"
SRC_URI="http://people.easter-eggs.org/~valos/wmdrawer/${P}.tar.gz"
HOMEPAGE="http://people.easter-eggs.org/~valos/wmdrawer/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64 ~sparc ~ppc"

DEPEND="virtual/x11
	gtk2? (	>=x11-libs/gtk+-2 )
	!gtk2? ( >=media-libs/gdk-pixbuf-0.22.0 )
	>=app-arch/gzip-1.3.3-r4
	>=sys-apps/sed-4"

src_unpack ()
{
	unpack ${A}
	cd ${S}
	if use gtk2 ; then
		epatch ${FILESDIR}/${P}-gtk+-2.patch
	fi

	# Honour Gentoo CFLAGS
	sed -i -e "s|-O3|${CFLAGS}|" Makefile
}

src_compile()
{
	emake || die "make failed!"
}

src_install()
{
	dobin wmdrawer
	dodoc COPYING INSTALL README TODO AUTHORS ChangeLog wmdrawerrc.example
	gzip -cd doc/wmdrawer.1x.gz > wmdrawer.1
	doman wmdrawer.1
}
