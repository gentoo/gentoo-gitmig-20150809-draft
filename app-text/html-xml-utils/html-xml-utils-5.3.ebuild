# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/html-xml-utils/html-xml-utils-5.3.ebuild,v 1.2 2010/01/02 11:25:35 fauli Exp $

inherit eutils

DESCRIPTION="A number of simple utilities for manipulating HTML and XML files."
SRC_URI="http://www.w3.org/Tools/HTML-XML-utils/${P}.tar.gz"
HOMEPAGE="http://www.w3.org/Tools/HTML-XML-utils/"
LICENSE="W3C"

IUSE=""
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86 ~x86-linux ~ppc-macos ~x86-macos"
SLOT="0"

RDEPEND="dev-util/gperf"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_install () {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README TODO
}
