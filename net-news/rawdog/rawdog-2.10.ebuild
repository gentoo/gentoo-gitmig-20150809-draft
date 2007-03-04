# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/rawdog/rawdog-2.10.ebuild,v 1.2 2007/03/04 18:34:23 lucass Exp $

NEED_PYTHON=2.2

inherit distutils

DESCRIPTION="Rawdog - RSS Aggregator Without Delusions Of Grandeur"
SRC_URI="http://offog.org/files/${P}.tar.gz"
HOMEPAGE="http://offog.org/code/rawdog.html"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~s390 ~sparc ~x86"
LICENSE="GPL-2"
SLOT="0"
IUSE=""
DOCS="NEWS PLUGINS config style.css"
