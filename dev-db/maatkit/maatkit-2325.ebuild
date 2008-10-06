# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/maatkit/maatkit-2325.ebuild,v 1.1 2008/10/06 11:34:32 wschlich Exp $

inherit perl-app

IUSE=""
DESCRIPTION="maatkit: essential command-line utilities for MySQL"
HOMEPAGE="http://www.maatkit.org/"
SRC_URI="http://maatkit.googlecode.com/files/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
DEPEND="dev-perl/DBD-mysql"
