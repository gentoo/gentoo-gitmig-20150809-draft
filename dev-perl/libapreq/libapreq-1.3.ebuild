# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/libapreq/libapreq-1.3.ebuild,v 1.5 2004/07/14 18:35:48 agriffis Exp $

inherit perl-module eutils

DESCRIPTION="A Apache Request Perl Module"
HOMEPAGE="http://httpd.apache.org/apreq/"
SRC_URI="http://www.apache.org/dist/httpd/libapreq/${P}.tar.gz"

LICENSE="Apache-1.1 as-is"
SLOT="0"
KEYWORDS="~x86 amd64 ~ppc ~sparc alpha ia64"
IUSE=""

DEPEND=">=sys-apps/sed-4
	dev-perl/Apache-Test
	<dev-perl/mod_perl-1.99"

mydoc="TODO"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-statlink.patch || die
}
