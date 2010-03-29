# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/wdiff/wdiff-0.6.0.ebuild,v 1.1 2010/03/29 11:48:47 jer Exp $

EAPI="2"

inherit eutils toolchain-funcs

DESCRIPTION="Create a diff disregarding formatting"
HOMEPAGE="http://www.gnu.org/software/wdiff/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND="sys-apps/diffutils
	sys-apps/less"

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc ChangeLog NEWS README
}
