# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ben Lutgens <lamer@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/sniffit/sniffit-0.3.5.ebuild,v 1.1 2001/07/15 18:30:48 lamer Exp $
A=sniffit.0.3.5.tar.gz
S=${WORKDIR}/${PN}.0.3.5
DESCRIPTION="packet sniffer"
SRC_URI="http://reptile.rug.ac.be/~coder/sniffit/files/${A}"
HOMEPAGE="http://reptile.rug.ac.be/~coder/sniffit/sniffit.html"
DEPEND=""

#RDEPEND=""

src_compile() {
	try ./configure --infodir=/usr/share/info --mandir=/usr/share/man --prefix=/usr --host=${CHOST}
	
	try emake
	#try make
}

src_install () {
	
	 dobin sniffit
	 doman sniffit.5 sniffit.8
	 dodoc README.FIRST PLUGIN-HOWTO
}

