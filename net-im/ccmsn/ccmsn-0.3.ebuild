# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/ccmsn/ccmsn-0.3.ebuild,v 1.1 2002/06/30 23:41:45 owen Exp $

RP="ccmsn-0.3p3"
DESCRIPTION="A nice little MSN Client written in TclTk"
HOMEPAGE="http://messenger.compucreations.com"
LICENSE="gpl"

SLOT="0"
DEPEND="dev-lang/tcl dev-lang/tk"
RDEPEND=""

SRC_URI="http://messenger.compucreations.com/${RP}.tgz"

S=${WORKDIR}/${RP}

src_compile() {
	mkdir ${S}/${RP}
	mv $S/ccmsn $S/i $S/migmd5.tcl $S/$RP
}

src_install () {
	dodir /usr/lib/
	mv $S/$RP ${D}/usr/lib/
	cp $S/README ${D}/usr/lib/$RP
	dodoc GNUGPL README TODO changelog
	dobin ${FILESDIR}/ccmsn
}
