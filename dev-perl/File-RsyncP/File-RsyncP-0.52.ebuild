# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-RsyncP/File-RsyncP-0.52.ebuild,v 1.1 2004/09/18 05:15:41 rac Exp $

inherit perl-module

IUSE=""

SRC_URI="mirror://sourceforge/perlrsync/${P}.tar.gz"

DESCRIPTION="An rsync perl module"
HOMEPAGE="http://perlrsync.sourceforge.net/"
LICENSE="GPL-2"
CATEGORY="dev-perl"

KEYWORDS="~amd64 ~x86"
SLOT="0"

RDEPEND="net-misc/rsync"

mydoc="Changes LICENSE README"
