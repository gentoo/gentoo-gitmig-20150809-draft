# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/quilt/quilt-0.32-r1.ebuild,v 1.3 2006/08/26 07:40:02 wormo Exp $

inherit bash-completion

DESCRIPTION="quilt patch manager"
HOMEPAGE="http://savannah.nongnu.org/projects/quilt"
SRC_URI="http://savannah.nongnu.org/download/quilt/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

RDEPEND="dev-util/diffstat
	media-gfx/graphviz"

src_install() {
	make BUILD_ROOT="${D}" install || die "make install failed"

	rm -rf ${D}/usr/share/doc/${P}
	dodoc AUTHORS BUGS quilt.changes doc/README doc/quilt.pdf \
		doc/sample.quiltrc

	rm -rf ${D}/etc/bash_completion.d
	dobashcompletion bash_completion ${PN}
}
