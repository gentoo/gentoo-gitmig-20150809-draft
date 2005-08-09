# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/passook/passook-1.0.0.ebuild,v 1.20 2005/08/09 19:26:13 metalgod Exp $

inherit eutils

S=${WORKDIR}
DESCRIPTION="Password generator capable of generating pronounceable and/or secure passwords."
SRC_URI="http://mackers.com/projects/passook/${PN}.tar.gz"
HOMEPAGE="http://mackers.com/misc/scripts/passook/"
IUSE=""

SLOT="0"
LICENSE="as-is"
KEYWORDS="~amd64 ppc ppc-macos ppc64 sparc x86"

DEPEND="dev-lang/perl
	sys-apps/grep
	sys-apps/miscfiles"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/passook.diff
}

src_install() {
	dobin passook
	dodoc README passook.cgi
}
