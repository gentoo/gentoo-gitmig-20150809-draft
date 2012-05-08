# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/iptraf-ng/iptraf-ng-1.1.2.ebuild,v 1.2 2012/05/08 17:38:57 jer Exp $

EAPI=4

DESCRIPTION="A console-based network monitoring utility"
HOMEPAGE="http://fedorahosted.org/iptraf-ng/"
SRC_URI="http://fedorahosted.org/releases/${PN:0:1}/${PN:1:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-2 doc? ( FDL-1.1 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="doc"

RDEPEND=">=sys-libs/ncurses-5.7-r7"
DEPEND="
	${RDEPEND}
	!net-analyzer/iptraf
"

DOCS="CHANGES FAQ README RELEASE-NOTES"

src_install() {
	default
	use doc && \
		dohtml -r \
			Documentation/*.html \
			Documentation/*.png \
			Documentation/stylesheet-images
	keepdir /var/{lib,log,lock}/iptraf-ng #376157
}
