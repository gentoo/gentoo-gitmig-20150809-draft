# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-RawIP/Net-RawIP-0.09d.ebuild,v 1.3 2003/05/08 16:53:46 rac Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Perl Net::RawIP - Raw IP packets manipulation Module"
SRC_URI="http://www.cpan.org/modules/by-module/Net/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/"

DEPEND="net-libs/libpcap"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86"

src_unpack() {
	unpack ${A}

	# This patch makes sure CFLAGS are applied properly instead of
	# being runon additions to the previously defined symbol.
	# Attempts to address the problem in bug 16388 without completely
	# losing CFLAGS.  The patch submitted to that bug chose to remove
	# the $ENV{'CFLAGS'}.  With the current state of MakeMaker, this
	# would be a perfectly acceptable choice, because the approach
	# taken here ends up with two sets of CFLAGS in the compile line.
	# However, I believe that it may be more prudent in the long run
	# to try to accommodate what I think the original intention of the
	# Makefile was.  Perhaps on some system with some (maybe future)
	# version of MakeMaker, this would be the only way to convey
	# CFLAGS.  Since duplication of CFLAGS is harmless, I'm going to
	# go with adding the space instead of taking out the $ENV{CFLAGS}.

	# Robert Coie <rac@gentoo.org> 2003.05.08

	sed -i -e "s/D_IFLIST_'\./D_IFLIST_ '\./" ${S}/Makefile.PL
}