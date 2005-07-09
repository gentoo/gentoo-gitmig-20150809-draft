# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-RsyncP/File-RsyncP-0.52.ebuild,v 1.4 2005/07/09 23:12:00 swegener Exp $

inherit perl-module

IUSE=""

SRC_URI="mirror://sourceforge/perlrsync/${P}.tar.gz"

DESCRIPTION="An rsync perl module"
HOMEPAGE="http://perlrsync.sourceforge.net/"
LICENSE="GPL-2"

KEYWORDS="~amd64 ~x86 ~ppc ~sparc"
SLOT="0"

RDEPEND="net-misc/rsync"

mydoc="Changes LICENSE README"
