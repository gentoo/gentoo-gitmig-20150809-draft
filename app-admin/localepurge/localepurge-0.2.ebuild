# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/localepurge/localepurge-0.2.ebuild,v 1.11 2004/03/12 10:45:38 mr_bones_ Exp $

DESCRIPTION="Script to recover diskspace wasted for unneeded locale files and localized man pages"
HOMEPAGE="http://www.gentoo.org/~bass/"
SRC_URI="mirror://gentoo/${P}.tbz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc alpha hppa"

DEPEND=""
RDEPEND="app-shells/bash"

S=${WORKDIR}/${PN}

src_install() {
	insinto /var/cache/localepurge
	doins defaultlist
	dosym /var/cache/localepurge/defaultlist /var/cache/localepurge/localelist
	insinto /etc/
	doins locale.nopurge
	dobin localepurge
	dodoc copyright
	doman localepurge.8
}
