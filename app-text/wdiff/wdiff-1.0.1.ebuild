# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/wdiff/wdiff-1.0.1.ebuild,v 1.1 2011/09/19 16:33:06 radhermit Exp $

EAPI="4"

DESCRIPTION="Create a diff disregarding formatting"
HOMEPAGE="http://www.gnu.org/software/wdiff/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~sparc-solaris"
IUSE="experimental"

DEPEND="
	sys-apps/diffutils
	sys-apps/less"
RDEPEND="${DEPEND}"

src_configure() {
	econf \
		$(use_enable experimental)
}
