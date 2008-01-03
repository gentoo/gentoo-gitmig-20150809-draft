# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-Path-Expand/File-Path-Expand-1.02.ebuild,v 1.5 2008/01/03 01:53:49 joslwah Exp $

inherit perl-module

DESCRIPTION="Expand filenames"
SRC_URI="mirror://cpan/authors/id/R/RC/RCLAMP/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~rclamp/"

LICENSE="Artistic"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE=""

SRC_TEST="do"
SLOT="0"

DEPEND="dev-lang/perl dev-perl/module-build"
