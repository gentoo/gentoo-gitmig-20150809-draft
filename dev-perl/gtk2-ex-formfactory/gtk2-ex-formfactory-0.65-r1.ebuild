# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/gtk2-ex-formfactory/gtk2-ex-formfactory-0.65-r1.ebuild,v 1.3 2007/07/10 23:33:29 mr_bones_ Exp $

inherit perl-module

MY_P=Gtk2-Ex-FormFactory-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Gtk2 FormFactory"
HOMEPAGE="http://www.exit1.org/Gtk2-Ex-FormFactory/"
SRC_URI="mirror://cpan/modules/by-module/Gtk2/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ia64 ppc ppc64 sparc x86"
IUSE=""

DEPEND="dev-perl/gtk2-perl
	dev-lang/perl"
SRC_TEST="do"
