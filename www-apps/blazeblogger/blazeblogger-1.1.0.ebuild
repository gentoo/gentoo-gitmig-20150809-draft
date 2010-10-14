# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/blazeblogger/blazeblogger-1.1.0.ebuild,v 1.1 2010/10/14 01:01:41 xmw Exp $

inherit bash-completion

DESCRIPTION="a simple-to-use but capable CMS for the command line, producing static content"
HOMEPAGE="http://blaze.blackened.cz/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="FDL-1.3 GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"

src_install() {
	emake prefix="${D}/usr" install

	if use bash-completion ; then
		dobashcompletion unix/bash_completion/${PN}
	fi
}
