# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/s3cmd/s3cmd-0.9.9.91.ebuild,v 1.3 2010/07/16 09:59:11 fauli Exp $

inherit distutils

KEYWORDS="amd64 x86"
DESCRIPTION="Command line client for Amazon S3"
HOMEPAGE="http://s3tools.org/s3cmd"
SRC_URI="mirror://sourceforge/s3tools/${P}.tar.gz"
LICENSE="GPL-2"

IUSE=""
SLOT="0"

RDEPEND=">=dev-lang/python-2.4
	dev-python/elementtree"

src_install() {
	S3CMD_INSTPATH_DOC=/usr/share/doc/${PF} distutils_src_install
}
