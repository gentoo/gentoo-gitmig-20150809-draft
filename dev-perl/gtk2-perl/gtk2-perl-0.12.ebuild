# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/gtk2-perl/gtk2-perl-0.12.ebuild,v 1.4 2004/07/14 17:44:43 agriffis Exp $

IUSE="xml"
inherit perl-module

MY_P=Gtk2-Perl-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Perl bindings for GTK2"
SRC_URI="mirror://sourceforge/gtk2-perl/${MY_P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/gtk2-perl/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~alpha ~ppc"

DEPEND="${DEPEND}
	=x11-libs/gtk+-2*
	xml? ( dev-perl/XML-Writer dev-perl/XML-Parser )
	>=dev-perl/Inline-0.44
	dev-perl/inline-files
	>=dev-perl/Parse-RecDescent-0.80"

src_compile() {
	echo "y" | perl-module_src_compile
	perl-module_src_test
}

src_install () {
	perl-module_src_install
}
