# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellm-newsticker/gkrellm-newsticker-0.3.5.ebuild,v 1.6 2004/03/26 23:10:05 aliz Exp $

IUSE=""
S=${WORKDIR}/${PN}
DESCRIPTION="A news headlines scroller for GKrellM2"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
HOMEPAGE="http://gkrellm-newsticker.sourceforge.net/"

DEPEND="=app-admin/gkrellm-2*
	net-ftp/curl"

SLOT="2"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc alpha ~hppa"

src_compile() {
	make || die
}

src_install () {
	insinto /usr/lib/gkrellm2/plugins
	doins newsticker.so
	dodoc README Changelog AUTHORS FAQ THEMES

	dodoc ${FILESDIR}/rdf-sources
}
