# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/kissme/kissme-0.19.ebuild,v 1.7 2002/10/04 05:11:22 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Tiny, JITless JVM"
SRC_URI="mirror://sourceforge/kissme/${P}.tar.gz"
HOMEPAGE="http://kissme.sourceforge.net/"
DEPEND=">=virtual/jre-1.2
	>=dev-java/makeme-0.02
	>=dev-libs/gmp-3.1.1
	=dev-java/kissme-classpath-0.19"
RDEPEND="=dev-java/kissme-classpath-0.19"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

src_compile() {
	makeme || die
}

src_install () {
	dodoc AUTHORS COPYING NEWS
	dodoc doc/*.txt
	dodoc doc/{TAGS,TIMING}
	dohtml -r doc/*
	exeinto /usr/bin
	newexe kissme kissme-bin
	newexe ${FILESDIR}/kissme.sh kissme
}
