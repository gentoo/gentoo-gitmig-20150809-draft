# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/gnome2-wnck/gnome2-wnck-0.04-r1.ebuild,v 1.9 2006/04/26 20:18:17 mcummings Exp $

IUSE=""
inherit perl-module eutils

MY_P=Gnome2-Wnck-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Perl interface to the Window Navigator Construction Kit"
SRC_URI="mirror://sourceforge/gtk2-perl/${MY_P}.tar.gz"
HOMEPAGE="http://gtk2-perl.sourceforge.net/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc amd64"

DEPEND=">=dev-perl/glib-perl-1.042
	>=dev-perl/gtk2-perl-1.042
	<x11-libs/libwnck-2.10.0
	dev-perl/extutils-pkgconfig
	>=dev-perl/extutils-depends-0.2"

src_unpack() {
	unpack ${A}
	cd ${S}

	# 2004.08.14 mcummings
	# Patch submitted in bug 57713 by Delfim Machado to address compile
	# failures
	epatch ${FILESDIR}/window_close_patch

}
