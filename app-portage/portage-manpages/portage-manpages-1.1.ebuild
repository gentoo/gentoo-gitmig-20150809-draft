# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/portage-manpages/portage-manpages-1.1.ebuild,v 1.2 2005/07/23 15:27:05 gongloo Exp $

DESCRIPTION="collection of Gentoo manpages"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ~ppc-macos ppc64 s390 sh sparc x86"
IUSE=""

DEPEND=""
RDEPEND="sys-apps/man"

S=${WORKDIR}/man

src_install() {
	doman * || die
}
