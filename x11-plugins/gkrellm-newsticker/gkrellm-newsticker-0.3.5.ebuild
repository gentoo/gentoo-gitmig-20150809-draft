# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/gentoo-x86/app-misc/gkrellm-volume-0.8.ebuild,v 1.0 
# 26 Apr 2001 21:30 CST blutgens Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="A news headlines scroller for GKrellM2"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
HOMEPAGE="http://gkrellm-newsticker.sourceforge.net/"

DEPEND="=app-admin/gkrellm-2*
	net-ftp/curl"

SLOT="2"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~mips ~hppa"

src_compile() {
	make || die
}

src_install () {
	insinto /usr/lib/gkrellm2/plugins
	doins newsticker.so
	dodoc README Changelog AUTHORS FAQ THEMES

	dodoc ${FILESDIR}/rdf-sources
}
