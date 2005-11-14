# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmdrawer/wmdrawer-0.10.5-r2.ebuild,v 1.3 2005/11/14 14:33:47 metalgod Exp $

inherit eutils

IUSE="gtk"
DESCRIPTION="wmDrawer is a dock application (dockapp) which provides a drawer (retractable button bar) to launch applications"
SRC_URI="http://people.easter-eggs.org/~valos/wmdrawer/${P}.tar.gz"
HOMEPAGE="http://people.easter-eggs.org/~valos/wmdrawer/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc ~sparc x86"

DEPEND="virtual/x11
	gtk? (	>=x11-libs/gtk+-2 )
	!gtk? ( >=media-libs/gdk-pixbuf-0.22.0 )
	>=app-arch/gzip-1.3.3-r4
	>=sys-apps/sed-4"

src_unpack ()
{
	unpack ${A}
	cd ${S}
	if use gtk ; then
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
	dodoc README TODO AUTHORS ChangeLog wmdrawerrc.example
	gzip -cd doc/wmdrawer.1x.gz > wmdrawer.1
	doman wmdrawer.1
}
