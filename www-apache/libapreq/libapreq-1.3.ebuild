# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/libapreq/libapreq-1.3.ebuild,v 1.2 2005/05/29 16:08:59 corsair Exp $

inherit perl-module eutils

DESCRIPTION="A Apache Request Perl Module"
HOMEPAGE="http://httpd.apache.org/apreq/"
SRC_URI="http://www.apache.org/dist/httpd/libapreq/${P}.tar.gz"

LICENSE="Apache-1.1 as-is"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ~ppc ppc64 sparc ~x86"
IUSE=""

DEPEND=">=sys-apps/sed-4
	dev-perl/Apache-Test
	<www-apache/mod_perl-1.99"

mydoc="TODO"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-statlink.patch || die
}
