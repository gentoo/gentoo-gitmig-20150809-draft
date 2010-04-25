# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-misc/surl/surl-0.7.0.ebuild,v 1.1 2010/04/25 13:40:58 wired Exp $

EAPI=3
PYTHON_DEPEND="2"

inherit python

DESCRIPTION="surl is a URL shortening command line application that supports various sites."
HOMEPAGE="http://launchpad.net/surl"
SRC_URI="http://launchpad.net/${PN}/trunk/0.7/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_install() {
	dobin surl.py || die "installation failed"

	dodoc AUTHORS.txt ChangeLog.txt || die "doc installation failed"
}
