# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-Object/HTML-Object-2.15.ebuild,v 1.11 2003/02/13 11:09:25 vapier Exp $

inherit perl-module

MY_P=html_object-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="A HTML development and delivery Perl Module"
SRC_URI="mirror://sourceforge/htmlobject/${MY_P}.tar.gz"
HOMEPAGE="http://htmlobject.sourceforge.net"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 ppc sparc alpha"

mydoc="LICENSE TODO"
