# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/disspam/disspam-0.12.ebuild,v 1.2 2003/05/29 02:10:15 strider Exp $

S=${WORKDIR}/disspam
DESCRIPTION="A Perl script that removes spam from POP3 mailboxes based on RBLs."
HOMEPAGE="http://www.topfx.com/"
SRC_URI="http://www.topfx.com/dist/${P}.tar.gz"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86 ~ppc ~sparc ~hppa ~alpha ~mips"

DEPEND=">=dev-lang/perl-5.6.1
	>=dev-perl/libnet-1.11
	>=dev-perl/Net-DNS-0.12"
	
src_install() {
    #This doesnt look neat but makes it work
	sed -e 's/\/usr\/local\/bin\/perl/\/usr\/bin\/perl/' disspam.pl > disspam-fixed.pl
	mv disspam-fixed.pl disspam.pl
	dobin disspam.pl
	dodoc changes.txt configuration.txt readme.txt sample.conf
}
