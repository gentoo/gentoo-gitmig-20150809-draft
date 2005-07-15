# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/cryptix-asn1-bin/cryptix-asn1-bin-20011119.ebuild,v 1.3 2005/07/15 17:30:23 axxo Exp $

inherit java-pkg

DESCRIPTION="Aims at facilitating the task programmers face in coding, accessing and generating java-bound, both types and values, defined as ASN.1 constructs, or encoded as such."
HOMEPAGE="http://cryptix-asn1.sourceforge.net/"
SRC_URI="mirror://gentoo/Cryptix-asn1-20011119.tar.gz"

LICENSE="CGL"
SLOT="0"
KEYWORDS="x86 amd64 ~ppc"
IUSE=""
DEPEND=""
RDEPEND=">=virtual/jre-1.4"

S=${WORKDIR}/Cryptix-asn1-${PV}

src_install() {
	java-pkg_dojar ${PN/-bin/}.jar
}
