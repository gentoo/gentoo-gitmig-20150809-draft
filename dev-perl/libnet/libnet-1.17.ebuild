# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/libnet/libnet-1.17.ebuild,v 1.6 2004/06/25 00:41:49 agriffis Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="A URI Perl Module"
SRC_URI="http://cpan.valueclick.com/modules/by-category/05_Networking_Devices_IPC/Net/${P}.tar.gz"
HOMEPAGE="http://cpan.valueclick.com/modules/by-category/05_Networking_Devices_IPC/Net/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86 ~amd64 ppc ~sparc alpha ~hppa ia64 s390"

src_compile() {
	cp ${O}/files/libnet.cfg .
	perl-module_src_compile
}
