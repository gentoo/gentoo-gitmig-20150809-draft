# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellm-newsticker/gkrellm-newsticker-0.3.5.ebuild,v 1.14 2005/04/27 20:36:29 herbs Exp $

inherit multilib

DESCRIPTION="A news headlines scroller for GKrellM2"
HOMEPAGE="http://gk-newsticker.sourceforge.net/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="x86 ppc ~sparc alpha hppa amd64"
IUSE=""

DEPEND="=app-admin/gkrellm-2*
		net-misc/curl"

S=${WORKDIR}/${PN}

src_compile() {
	make || die
}

src_install() {
	insinto /usr/$(get_libdir)/gkrellm2/plugins
	doins newsticker.so || die
	dodoc README Changelog AUTHORS FAQ THEMES

	dodoc ${FILESDIR}/rdf-sources
}
