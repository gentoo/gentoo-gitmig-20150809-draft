# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-RsyncP/File-RsyncP-0.68.ebuild,v 1.8 2008/07/30 16:37:19 ranger Exp $

inherit perl-module

IUSE=""

SRC_URI="mirror://cpan/authors/id/C/CB/CBARRATT/${P}.tar.gz"

DESCRIPTION="An rsync perl module"
HOMEPAGE="http://perlrsync.sourceforge.net/"
LICENSE="GPL-2"

KEYWORDS="amd64 ia64 ~ppc ~ppc64 sparc x86"
SLOT="0"

DEPEND="net-misc/rsync
		dev-lang/perl"

mydoc="LICENSE README"
