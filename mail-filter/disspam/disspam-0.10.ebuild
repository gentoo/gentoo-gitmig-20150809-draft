# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/disspam/disspam-0.10.ebuild,v 1.5 2005/12/30 12:00:52 mcummings Exp $

S=${WORKDIR}/disspam
DESCRIPTION="A Perl script that removes spam from POP3 mailboxes based on RBLs."
HOMEPAGE="http://www.topfx.com/"
SRC_URI="http://www.topfx.com/dist/${P}.tar.gz"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 sparc"
IUSE=""

DEPEND=">=dev-lang/perl-5.6.1
	>=perl-core/libnet-1.11
	>=dev-perl/Net-DNS-0.12"

src_install() {
	dobin disspam.pl
	dodoc changes.txt configuration.txt readme.txt sample.conf
}
