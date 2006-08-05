# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-Object/HTML-Object-2.15-r1.ebuild,v 1.12 2006/08/05 04:24:57 mcummings Exp $

inherit perl-module

MY_P=html_object-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="A HTML development and delivery Perl Module"
SRC_URI="mirror://sourceforge/htmlobject/${MY_P}.tar.gz"
HOMEPAGE="http://htmlobject.sourceforge.net"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE=""

mydoc="LICENSE TODO"


DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
