# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/libapreq/libapreq-1.3.ebuild,v 1.1 2003/12/23 20:43:39 rac Exp $

inherit perl-module

DESCRIPTION="A Apache Request Perl Module"
SRC_URI="http://www.apache.org/dist/httpd/libapreq/${P}.tar.gz"
HOMEPAGE="http://httpd.apache.org/apreq/"
SLOT="0"
LICENSE="Apache-1.1 as-is"
KEYWORDS="~x86 amd64 ~ppc ~sparc ~alpha ~ia64"

DEPEND="${DEPEND}
	>=sys-apps/sed-4
	dev-perl/Apache-Test
	<dev-perl/mod_perl-1.99"

mydoc="TODO"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-statlink.patch || die
}

