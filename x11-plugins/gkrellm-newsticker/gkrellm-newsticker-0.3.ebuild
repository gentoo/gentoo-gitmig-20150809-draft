# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/gentoo-x86/app-misc/gkrellm-volume-0.8.ebuild,v 1.0 
# 26 Apr 2001 21:30 CST blutgens Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="A news headlines scroller for GKrellM"
SRC_URI="mirror://sourceforge/gk-newsticker/${P}.tar.gz"
HOMEPAGE="http://gkrellm-newsticker.sourceforge.net/"

DEPEND="=app-admin/gkrellm-1.2*
	net-ftp/curl"

SLOT="1"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~mips ~hppa"

src_compile() {
	make || die
}

src_install () {
	insinto /usr/lib/gkrellm/plugins
	doins newsticker.so
	dodoc README Changelog AUTHORS FAQ THEMES

	dodoc ${FILESDIR}/rdf-sources
}
