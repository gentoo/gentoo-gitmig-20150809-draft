# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/localepurge/localepurge-0.2.ebuild,v 1.5 2002/10/18 13:31:45 aliz Exp $

S="${WORKDIR}/${PN}"
DESCRIPTION="Script to recover diskspace wasted for unneeded locale files and localized man pages."
SRC_URI="mirror://gentoo/${P}.tbz2"
HOMEPAGE="http://www.gentoo.org/~bass"
LICENSE="GPL-2"
DEPEND=""
RDEPEND="sys-apps/bash"
IUSE=""

KEYWORDS="x86 ppc"
SLOT="0"

src_install() {
	dodir var/cache/localepurge
	insinto var/cache/localepurge
	doins defaultlist
	dosym /var/cache/localepurge/defaultlist var/cache/localepurge/localelist
	insinto etc/
	doins locale.nopurge
	dobin localepurge

	dodoc copyright
	doman localepurge.8
}
