# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ben Lutgens <blutgens@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-mail/lbdb/lbdb-0.24.ebuild,v 1.1 2001/07/10 19:34:41 lamer Exp $
P=lbdb_0.24
S=${WORKDIR}/lbdb-0.24
DESCRIPTION="This is a sample skeleton ebuild file"
SRC_URI="http://www.spinnaker.de/debian/${P}.tar.gz"
HOMEPAGE="http://www.spinnaker.de/debian/lbdb.html"
DEPEND=">=net-mail/mutt-1.2.5"

#RDEPEND=""
# NOTE: You need to have the Palm::PDB and Palm::Address Perl modules
# installed to use the m_palm module. use perl's CPAN module to fetch
# and install "perl -MCPAN -e shell" see "perldoc CPAN"



src_compile() {
	try ./configure --infodir=/usr/share/info --mandir=/usr/share/man \
		--prefix=/usr --sysconfdir=/etc --libdir=/usr/lib/lbdb --host=${CHOST}
	
	try emake
	#try make
}

src_install () {
	
	# try make prefix=${D}/usr install

    try make install_prefix=${D} install
	 dodoc README INSTALL COPYING NEWS TODO
}

