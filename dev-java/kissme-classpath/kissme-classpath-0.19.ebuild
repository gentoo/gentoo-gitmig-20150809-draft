# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-java/kissme-classpath/kissme-classpath-0.19.ebuild,v 1.6 2002/08/01 18:40:31 karltk Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GNU Classpath specifically tailored to kissme"
SRC_URI="mirror://sourceforge/kissme/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/classpath/classpath.html"
DEPEND=">=virtual/jdk-1.3
        >=dev-java/jikes-1.13
        app-shells/zsh"
RDEPEND=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

src_compile() {
	make build || die
}

src_install () {
	dodir usr/share/kissme/classpath
	dodoc src/README
	DESTDIR=${D} sh install.sh || die
	echo "/usr/share/kissme/classpath" > ${D}/usr/share/kissme/classpath.env
}

