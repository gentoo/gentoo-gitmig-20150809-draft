# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Apache-Session/Apache-Session-1.54.ebuild,v 1.4 2003/06/21 21:36:35 drobbins Exp $

inherit perl-module

IUSE=""

S=${WORKDIR}/${P}
DESCRIPTION="Perl module for Apache::Session"
SRC_URI="http://search.cpan.org/CPAN/authors/id/J/JB/JBAKER/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/author/JBAKER/Apache-Session-1.54/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ppc sparc alpha"

DEPEND="${DEPEND}
	dev-perl/Digest-MD5
	dev-perl/Storable"
