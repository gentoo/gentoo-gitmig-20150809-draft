# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/TermReadKey/TermReadKey-2.19-r1.ebuild,v 1.11 2005/01/04 13:53:44 mcummings Exp $

inherit perl-module

DESCRIPTION="Change terminal modes, and perform non-blocking reads."
HOMEPAGE="http://search.cpan.org/~jstowe/${P}/"
SRC_URI="mirror://cpan/authors/id/J/JS/JSTOWE/${P}.tar.gz"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ppc sparc alpha hppa"
IUSE=""

mymake="/usr"
