# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/gnome2-wnck/gnome2-wnck-0.14.ebuild,v 1.7 2007/03/30 15:02:56 mcummings Exp $

IUSE=""
inherit perl-module eutils

MY_P=Gnome2-Wnck-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Perl interface to the Window Navigator Construction Kit"
SRC_URI="mirror://sourceforge/gtk2-perl/${MY_P}.tar.gz"
HOMEPAGE="http://gtk2-perl.sourceforge.net/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ~ia64 ppc sparc x86"
#SRC_TEST="do"

DEPEND=">=dev-perl/glib-perl-1.042
	>=dev-perl/gtk2-perl-1.042
	>=x11-libs/libwnck-2.12.0
	dev-perl/extutils-pkgconfig
	dev-util/pkgconfig
	>=dev-perl/extutils-depends-0.2
	dev-lang/perl"

src_unpack() {
	unpack ${A}
	cd ${S}

	# 2004.08.14 mcummings
	# Patch submitted in bug 57713 by Delfim Machado to address compile
	# failures
	epatch ${FILESDIR}/window_close_patch

}


