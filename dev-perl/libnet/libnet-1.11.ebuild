# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/libnet/libnet-1.11.ebuild,v 1.5 2002/07/25 05:23:31 seemant Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="A URI Perl Module"
SRC_URI="http://cpan.valueclick.com/modules/by-category/05_Networking_Devices_IPC/Net/${P}.tar.gz"
HOMEPAGE="http://cpan.valueclick.com/modules/by-category/05_Networking_Devices_IPC/Net/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86"

src_compile() {
	cp ${O}/files/libnet.cfg .
	base_src_compile
}
