# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/f-prot/f-prot-3.12c.ebuild,v 1.7 2003/04/24 10:51:18 vapier Exp $

inherit eutils

MY_P=fp-linux-sb-${PV}
DESCRIPTION="Frisk Software's f-prot virus scanner"
HOMEPAGE="http://www.f-prot.com/"
SRC_URI="ftp://ftp.f-prot.com/pub/linux/${MY_P}.tar.gz"

SLOT="0"
LICENSE="F-PROT"
KEYWORDS="x86 sparc"

# unzip and wget are needed for the check-updates.sh script
DEPEND="virtual/glibc"
RDEPEND=">=app-arch/unzip-5.42-r1
	>=net-misc/wget-1.8.2"

PROVIDE="virtual/antivirus"

S=${WORKDIR}/${PN}

src_unpack () {
	unpack ${A}
	cd ${WORKDIR}
	epatch ${FILESDIR}/${PN}-${PV}.diff
}

src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	doman man8/f-prot.8 man8/check-updates.sh.8
	dodoc LICENSE CHANGES INSTALL.smallbusiness README

	dodir /opt/f-prot /opt/f-prot/tmp
	insinto /opt/f-prot
	insopts -m 755
	doins f-prot f-prot.sh check-updates.sh checksum
	insopts -m 644
	doins *.DEF ENGLISH.TX0
}
