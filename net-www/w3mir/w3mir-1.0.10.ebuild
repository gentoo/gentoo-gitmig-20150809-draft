# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-www/w3mir/w3mir-1.0.10.ebuild,v 1.1 2003/05/07 22:04:57 rac Exp $

inherit perl-module

DESCRIPTION="w3mir is a all purpose HTTP copying and mirroring tool"
SRC_URI="http://langfeldt.net/w3mir/${P}.tar.gz"
HOMEPAGE="http://langfeldt.net/w3mir/"
IUSE=""

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"

DEPEND="${DEPEND}
        >=dev-perl/URI-1.0.9
        >=dev-perl/libwww-perl-5.64-r1
        >=dev-perl/MIME-Base64-2.12"


