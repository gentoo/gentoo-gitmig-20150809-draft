# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/localepurge/localepurge-0.4.ebuild,v 1.2 2005/12/28 11:18:02 bass Exp $

DESCRIPTION="Script to recover diskspace wasted for unneeded locale files and localized man pages."
HOMEPAGE="http://www.josealberto.org/blog/?p=51"
SRC_URI="mirror://gentoo/${P}.tbz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ~ppc-macos ppc64 s390 sh sparc x86"
IUSE=""

DEPEND=""
RDEPEND="app-shells/bash"

S=${WORKDIR}/${PN}

src_install() {
	insinto /var/cache/localepurge
	doins defaultlist
	dosym defaultlist /var/cache/localepurge/localelist
	insinto /etc
	doins locale.nopurge
	dobin localepurge || die
	doman localepurge.8
}
