# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/s3cmd/s3cmd-0.9.4.ebuild,v 1.1 2007/09/23 00:07:05 jmglov Exp $

inherit distutils

KEYWORDS="~x86"
DESCRIPTION="command line S3 client"
HOMEPAGE="http://s3tools.logix.cz/s3cmd"
SRC_URI="mirror://sourceforge/s3tools/${P}.tar.gz"
LICENSE="GPL-2"

IUSE=""
SLOT="0"

RDEPEND=">=dev-lang/python-2.4
	dev-python/elementtree"
