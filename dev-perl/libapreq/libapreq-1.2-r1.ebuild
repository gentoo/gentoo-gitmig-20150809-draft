# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/libapreq/libapreq-1.2-r1.ebuild,v 1.2 2004/01/18 20:55:42 tuxus Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="A Apache Request Perl Module"
SRC_URI="http://cpan.valueclick.com/modules/by-category/15_World_Wide_Web_HTML_HTTP_CGI/Apache/${P}.tar.gz"
HOMEPAGE="http://cpan.valueclick.com/modules/by-category/15_World_Wide_Web_HTML_HTTP_CGI/Apache/${P}.readme"

SLOT="0"
LICENSE="Apache-1.1 as-is"
KEYWORDS="x86 amd64 ~ppc ~sparc ~alpha ~mips"

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

