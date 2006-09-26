# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/guile-www/guile-www-2.15.ebuild,v 1.2 2006/09/26 07:56:15 dberkholz Exp $

DESCRIPTION="Guile Scheme modules to facilitate HTTP, URL and CGI programming"
HOMEPAGE="http://www.glug.org/people/ttn/software/guile-www/"
SRC_URI="http://www.glug.org/people/ttn/software/guile-www/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86"
IUSE=""
RDEPEND="dev-util/guile"
DEPEND="${RDEPEND}"

src_install() {
	make DESTDIR="${D}" install || die "install failed"
}
