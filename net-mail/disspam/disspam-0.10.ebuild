# Copyright 2002 Robin Cull
# Distributed under the terms of the GNU General Public License v2
# Author: Robin Cull <robin@digitalevacuation.org>

DESCRIPTION="A Perl script that removes spam from POP3 mailboxes based on RBLs."
HOMEPAGE="http://www.topfx.com/"
LICENSE="Artistic"

DEPEND=">=sys-devel/perl-5.6.1
	>=dev-perl/libnet-1.11
	>=dev-perl/Net-DNS-0.12"

SRC_URI="http://freshmeat.net/redir/disspam/22053/url_tgz/${P}.tar.gz"
S=${WORKDIR}/disspam

	
src_install() {
	dobin disspam.pl
	dodoc changes.txt configuration.txt readme.txt sample.conf
}

pkg_postinst() {
	einfo "**************************************************************"
	einfo "* NOTE: DisSpam has been installed, check documentation	    *"
	einfo "* directory for sample configuration file sample.conf.  Also *"
	einfo "* instructions for setting up cron are in readme.txt.	    *"
	einfo "**************************************************************"
}
