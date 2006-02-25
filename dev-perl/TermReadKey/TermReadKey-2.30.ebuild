# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/TermReadKey/TermReadKey-2.30.ebuild,v 1.8 2006/02/25 23:55:35 kumba Exp $

inherit perl-module

DESCRIPTION="Change terminal modes, and perform non-blocking reads"
HOMEPAGE="http://search.cpan.org/~jstowe/${P}/"
SRC_URI="mirror://cpan/authors/id/J/JS/JSTOWE/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sh sparc x86"
IUSE=""

mymake="/usr"
