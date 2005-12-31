# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/sandboxshell/sandboxshell-0.3.ebuild,v 1.2 2005/12/31 11:58:58 vapier Exp $

DESCRIPTION="launch a sandboxed shell ... useful for debugging ebuilds"
HOMEPAGE="http://wh0rd.org/"
SRC_URI=""

LICENSE="public-domain"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sh sparc x86"
IUSE=""

DEPEND=""
RDEPEND="sys-apps/portage
	app-shells/bash"

S=${WORKDIR}

src_install() {
	dobin "${FILESDIR}"/sandboxshell || die
	doman "${FILESDIR}"/sandboxshell.1
	insinto /etc
	doins "${FILESDIR}"/sandboxshell.conf
}
