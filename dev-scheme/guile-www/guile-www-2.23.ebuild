# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/guile-www/guile-www-2.23.ebuild,v 1.7 2010/01/06 20:24:59 ranger Exp $

DESCRIPTION="Guile Scheme modules to facilitate HTTP, URL and CGI programming"
HOMEPAGE="http://www.gnuvola.org/software/guile-www/"
SRC_URI="http://www.gnuvola.org/software/guile-www/${P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="alpha amd64 ~ppc ~ppc64 sparc ~x86"
IUSE=""
RDEPEND="dev-scheme/guile"
DEPEND="${RDEPEND}"

src_install() {
	make DESTDIR="${D}" install || die "install failed"
}
