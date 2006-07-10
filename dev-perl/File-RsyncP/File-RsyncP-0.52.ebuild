# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-RsyncP/File-RsyncP-0.52.ebuild,v 1.7 2006/07/10 15:37:04 agriffis Exp $

inherit perl-module

IUSE=""

SRC_URI="mirror://sourceforge/perlrsync/${P}.tar.gz"

DESCRIPTION="An rsync perl module"
HOMEPAGE="http://perlrsync.sourceforge.net/"
LICENSE="GPL-2"

KEYWORDS="~amd64 ia64 ~ppc sparc x86"
SLOT="0"

RDEPEND="net-misc/rsync"

mydoc="Changes LICENSE README"
