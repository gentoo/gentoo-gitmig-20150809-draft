# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/yacas/yacas-1.2.2.ebuild,v 1.1 2007/11/07 23:26:11 bicatali Exp $

DESCRIPTION="Powerful general purpose computer algebra system"
HOMEPAGE="http://yacas.sourceforge.net/"
SRC_URI="http://${PN}.sourceforge.net/backups/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE="doc java server"

DEPEND="java? ( virtual/jdk )"

src_compile() {
	econf \
		$(use_enable doc html-doc) \
		$(use_enable server) \
		--with-html-dir="/usr/share/doc/${PF}/html" \
		|| die "econf failed"
	emake || die "emake failed"
	if use java; then
		cd JavaYacas
		emake -f makefile.yacas || die "emake java interface failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS README TODO || die
	if use java; then
		cd JavaYacas
		insinto /usr/share/${PN}
		doins yacas.jar hints.txt yacasconsole.html || die "doins java interface failed"
		echo "#!/bin/sh" > jyacas
		echo "java -jar /usr/share/${PN}/java.jar" >> jyacas
		exeinto /usr/bin
		doexe jyacas
	fi
}
