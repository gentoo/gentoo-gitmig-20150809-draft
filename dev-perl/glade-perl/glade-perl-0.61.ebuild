# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/glade-perl/glade-perl-0.61.ebuild,v 1.4 2004/07/14 17:38:55 agriffis Exp $

inherit perl-module

MY_P=Glade-Perl-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Perl bindings for Glade"
SRC_URI="ftp://ftp.cpan.org/pub/CPAN/modules/by-module/Glade/${MY_P}.tar.gz"
HOMEPAGE="http://www.perl.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~amd64 ~ppc ~sparc ~alpha"
IUSE=""

DEPEND="${DEPEND}
	   dev-util/glade
	   dev-perl/gtk-perl
	   dev-perl/XML-Parser
	   >=dev-perl/Unicode-String-2.07"

mydoc="Documentation/FAQ Documentation/INSTALL Documentation/NEWS Documentation/README Documentation/ROADMAP Documentation/TODO"
