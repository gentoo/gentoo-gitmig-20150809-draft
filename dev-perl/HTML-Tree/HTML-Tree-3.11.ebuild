# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author: Francisco Gimeno <kikov@fco-gimeno.com>
# Manteiner: José Alberto Suárez López <bass@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-Tree/HTML-Tree-3.11.ebuild,v 1.1 2002/05/14 19:19:12 bass Exp $ 
. /usr/portage/eclass/inherit.eclass || die
inherit perl-module

MY_P=HTML-Tree-${PV}

S=${WORKDIR}/${MY_P}

DESCRIPTION="A library to manage HTML-Tree in PERL"

SRC_URI="http://www.perl.com/CPAN/authors/id/S/SB/SBURKE/${P}.tar.gz"

HOMEPAGE="http://www.perl.com/CPAN/authors/id/S/SB/SBURKE/"

LICENSE="Artistic"

mydoc="Changes MANIFEST README"
DEPEND=">=dev-perl/HTML-Tagset-3.03 "


