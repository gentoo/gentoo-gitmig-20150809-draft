# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/metacity-setup/metacity-setup-0.7.1-r1.ebuild,v 1.6 2002/12/24 21:16:10 azarah Exp $

inherit gnome2

DESCRIPTION="a setup program for metacity"
HOMEPAGE="http://plastercast.tzo.com/~plastercast/Projects/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc  ppc"

DEPEND="x11-wm/metacity
	>=x11-libs/gtk+-2*
	>=dev-libs/glib-2*
	gnome-base/libgnomeui"
SRC_URI="http://unc.dl.sourceforge.net/sourceforge/metacity-setup/${P}.tar.gz"
S="${WORKDIR}/${P}"

DOCS="AUTHORS COPYING  ChangeLog INSTALL NEWS README"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p0 < ${FILESDIR}/metacity-setup-0.7.1-themedir.patch || die
}

