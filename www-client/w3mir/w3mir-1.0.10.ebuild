# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/w3mir/w3mir-1.0.10.ebuild,v 1.1 2005/03/18 16:17:09 seemant Exp $

inherit perl-module

DESCRIPTION="w3mir is a all purpose HTTP copying and mirroring tool"
SRC_URI="http://langfeldt.net/w3mir/${P}.tar.gz"
HOMEPAGE="http://langfeldt.net/w3mir/"
IUSE=""

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 ppc ~sparc alpha"

DEPEND="${DEPEND}
	>=dev-perl/URI-1.0.9
	>=dev-perl/libwww-perl-5.64-r1
	>=dev-perl/MIME-Base64-2.12"
