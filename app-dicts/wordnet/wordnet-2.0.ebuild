# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/wordnet/wordnet-2.0.ebuild,v 1.2 2004/08/03 11:43:50 dholm Exp $

inherit eutils

DESCRIPTION="WordNet : a lexical database for the English language"
HOMEPAGE="http://www.cogsci.princeton.edu/~wn/"
SRC_URI="ftp://ftp.cogsci.princeton.edu/pub/wordnet/${PV}/WordNet-${PV}.tar.gz"
DEPEND="tcl tk"
LICENSE="Princeton"
IUSE=""
SLOT="0"
KEYWORDS="~x86 ~ppc"
S=${WORKDIR}/WordNet-${PV}

src_unpack() {
	unpack $A
	epatch ${FILESDIR}/Makefiles.diff
}

src_compile() {
	MAKEOPTS="-e"
	PLATFORM=linux WN_ROOT=${T}/usr \
	WN_DICTDIR=${T}/usr/share/wordnet/dict \
	WN_MANDIR=${T}/usr/share/man \
	WN_DOCDIR=${T}/usr/share/doc/wordnet-${PV} \
	CFLAGS="${CFLAGS} -DUNIX -I${T}/usr/include" \
	emake SrcWorld || die
}

src_install() {
	cp -r ${T}/usr ${D}
}
