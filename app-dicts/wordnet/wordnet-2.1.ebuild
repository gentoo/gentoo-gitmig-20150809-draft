# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/wordnet/wordnet-2.1.ebuild,v 1.4 2007/02/10 23:05:52 opfer Exp $

inherit eutils

DESCRIPTION="A lexical database for the English language"
HOMEPAGE="http://wordnet.princeton.edu/"
SRC_URI="ftp://ftp.cogsci.princeton.edu/pub/wordnet/${PV}/WordNet-${PV}.tar.gz"
DEPEND="tk? ( dev-lang/tk )"
LICENSE="Princeton"
IUSE="tk"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc-macos ~x86"
S=${WORKDIR}/WordNet-${PV}

src_unpack() {
	unpack $A
	epatch "$FILESDIR/Wordnet-2.1-dict-location.patch"
	cd WordNet-2.1
	epatch "$FILESDIR/Wordnet-2.1-compile-fix-new.patch"
}

src_compile() {
	MAKEOPTS="-e"
	PLATFORM=linux WN_ROOT="${T}/usr" \
	WN_DICTDIR="${T}/usr/share/wordnet/dict" \
	WN_MANDIR="${T}/usr/share/man" \
	WN_DOCDIR="${T}/usr/share/doc/wordnet-${PV}" \
	CFLAGS="${CFLAGS} -DUNIX -I${T}/usr/include" \
	econf || die "Configuration Failed"
	emake || die "Make Failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "Install Failed"
}
