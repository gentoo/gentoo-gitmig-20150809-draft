# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-NFSLock/File-NFSLock-1.20.ebuild,v 1.4 2006/10/20 21:45:24 mcummings Exp $

inherit perl-module

DESCRIPTION="NFS compatible (safe) locking utility"
SRC_URI="http://cpan.uwinnipeg.ca/cpan/authors/id/B/BB/BBB/${P}.tar.gz"
HOMEPAGE="http://cpan.uwinnipeg.ca/dist/File-NFSLock"

SRC_TEST="do"
SLOT="0"
LICENSE="Artistic"
KEYWORDS="amd64 ~x86"
IUSE=""


DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
