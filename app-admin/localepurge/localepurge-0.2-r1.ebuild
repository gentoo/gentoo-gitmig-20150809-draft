# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/localepurge/localepurge-0.2-r1.ebuild,v 1.1 2004/07/13 09:25:06 bass Exp $

DESCRIPTION="Script to recover diskspace wasted for unneeded locale files and localized man pages"
HOMEPAGE="http://www.gentoo.org/~bass/"
SRC_URI="mirror://gentoo/${P}.tbz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha arm hppa amd64 ia64 ppc64 s390"
IUSE=""

DEPEND=""
RDEPEND="app-shells/bash"

S=${WORKDIR}/${PN}

src_install() {
	insinto /var/cache/localepurge
	doins defaultlist
	dosym /var/cache/localepurge/defaultlist /var/cache/localepurge/localelist
	insinto /etc/
	doins locale.nopurge
	dobin localepurge || die
	dodoc copyright
	doman localepurge.8
}
