# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/glade-perl/glade-perl-0.61.ebuild,v 1.9 2005/08/26 02:40:49 agriffis Exp $

inherit perl-module

MY_P=Glade-Perl-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Perl bindings for Glade"
SRC_URI="mirror://cpan/authors/id/D/DM/DMUSGR/${MY_P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~dmusgr/${MY_P}/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha amd64 ~ia64 ppc sparc x86"
IUSE=""

DEPEND="${DEPEND}
	   dev-util/glade
	   dev-perl/gtk-perl
	   dev-perl/XML-Parser
	   >=dev-perl/Unicode-String-2.07"

mydoc="Documentation/FAQ Documentation/INSTALL Documentation/NEWS Documentation/README Documentation/ROADMAP Documentation/TODO"
