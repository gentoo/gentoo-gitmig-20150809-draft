# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/gnome2-perl/gnome2-perl-0.03.ebuild,v 1.1 2003/07/07 13:49:25 mcummings Exp $

inherit perl-module

MY_P=Gnome2-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Perl bindings for Gnome2"
SRC_URI="mirror://sourceforge/gtk2-perl/${MY_P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/gtk2-perl/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~ppc ~alpha"

DEPEND="${DEPEND}
	>=x11-libs/gtk+-2.0
	>=gnome-base/libgnome-2.0
	=gnome-base/libgnomeprint-1.116.0
	>=dev-perl/gtk2-perl-0.10"

src_compile() {
	echo "y" | perl-module_src_compile
	perl-module_src_test
}

src_install () {
	perl-module_src_install
}

