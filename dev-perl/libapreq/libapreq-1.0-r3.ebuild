# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/libapreq/libapreq-1.0-r3.ebuild,v 1.2 2002/12/22 23:14:32 mcummings Exp $

inherit perl-post

S=${WORKDIR}/${P}
DESCRIPTION="A Apache Request Perl Module"
SRC_URI="http://cpan.valueclick.com/modules/by-category/15_World_Wide_Web_HTML_HTTP_CGI/Apache/${P}.tar.gz"
HOMEPAGE="http://cpan.valueclick.com/modules/by-category/15_World_Wide_Web_HTML_HTTP_CGI/Apache/${P}.readme"

SLOT="0"
LICENSE="Apache-1.1 as-is"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"

DEPEND="${DEPEND}
	<dev-perl/mod_perl-1.99"

mydoc="TODO"

src_compile() {
        perl Makefile.PL PREFIX=${D}/usr || die
		cp Cookie/Makefile Cookie/Makefile.bak
		cp Request/Makefile Request/Makefile.bak
		sed -e "s|LD_RUN_PATH = /var/tmp/portage/libapreq-1.0-r3/work/libapreq-1.0/Cookie/|LD_RUN_PATH = |" Cookie/Makefile.bak > Cookie/Makefile


		sed -e "s|LD_RUN_PATH = /var/tmp/portage/libapreq-1.0-r3/work/libapreq-1.0/Request/|LD_RUN_PATH = |" Request/Makefile.bak > Request/Makefile
	make
}

src_install() {
	make install

}
		
