# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IPC-Run/IPC-Run-0.80.ebuild,v 1.8 2006/10/20 19:48:42 kloeri Exp $

inherit perl-module

DESCRIPTION="system() and background procs w/ piping, redirs, ptys"
SRC_URI="mirror://cpan/authors/id/R/RS/RSOD/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/search?module=${PN}"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha amd64 ia64 ~ppc sparc ~x86"
IUSE=""

DEPEND=">=dev-perl/IO-Tty-1.0
	dev-lang/perl"
