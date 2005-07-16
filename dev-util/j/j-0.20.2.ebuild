# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/j/j-0.20.2.ebuild,v 1.7 2005/07/16 18:41:43 axxo Exp $

inherit java-pkg

DESCRIPTION="Programmer's text editor written in Java, includes Armed Bear Lisp."
HOMEPAGE="http://armedbear-j.sourceforge.net/"
SRC_URI="mirror://sourceforge/armedbear-${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64 ~ppc"
IUSE=""

RDEPEND=">=virtual/jre-1.4
	dev-java/xerces"
DEPEND=">=virtual/jdk-1.4
	${RDEPEND}"

src_compile() {
	econf \
		--with-jdk="$(java-config --jdk-home)" \
		--with-extensions=$(java-pkg_getjar xerces-2 xercesImpl.jar) \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		|| die "./configure failed"
	emake || die
}

src_install() {
	einstall || die
}
