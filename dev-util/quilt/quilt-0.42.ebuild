# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/quilt/quilt-0.42.ebuild,v 1.4 2006/08/26 07:40:02 wormo Exp $

inherit bash-completion

DESCRIPTION="quilt patch manager"
HOMEPAGE="http://savannah.nongnu.org/projects/quilt"
SRC_URI="http://savannah.nongnu.org/download/quilt/${P}.tar.gz"
# There are packages hosted at the savannah site, but the maintainers do not
# update them.  Which means we either have to hit the deb package or the suse
# RPM for a current version.
# yuck.
#SRC_URI="mirror://debian/pool/main/q/quilt/${P//-/_}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

RDEPEND="sys-apps/ed
	dev-util/diffstat
	media-gfx/graphviz"

src_install() {
	make BUILD_ROOT="${D}" install || die "make install failed"

	rm -rf ${D}/usr/share/doc/${P}
	dodoc AUTHORS BUGS TODO quilt.changes doc/README doc/README.MAIL \
		doc/quilt.pdf doc/sample.quiltrc

	rm -rf ${D}/etc/bash_completion.d
	dobashcompletion bash_completion
}
