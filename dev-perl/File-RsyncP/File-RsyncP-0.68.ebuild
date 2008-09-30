# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-RsyncP/File-RsyncP-0.68.ebuild,v 1.9 2008/09/30 12:59:07 tove Exp $

MODULE_AUTHOR=CBARRATT
inherit perl-module

DESCRIPTION="An rsync perl module"
HOMEPAGE="http://perlrsync.sourceforge.net/"

LICENSE="GPL-2"
KEYWORDS="amd64 ia64 ~ppc ~ppc64 sparc x86"
SLOT="0"
IUSE=""

DEPEND="net-misc/rsync
	dev-lang/perl"
