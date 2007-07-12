# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/ccmsn/ccmsn-0.3.ebuild,v 1.7 2007/07/12 05:34:48 mr_bones_ Exp $

IUSE=""
RP="${P}p3"
S=${WORKDIR}/${RP}
DESCRIPTION="A nice little MSN Client written in TclTk"
HOMEPAGE="http://messenger.compucreations.com/"
SRC_URI="http://messenger.compucreations.com/${RP}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

DEPEND="dev-lang/tcl dev-lang/tk"
RDEPEND=""

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
