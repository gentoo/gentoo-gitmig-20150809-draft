# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/sandboxshell/sandboxshell-0.1.ebuild,v 1.2 2003/08/01 03:45:50 vapier Exp $

DESCRIPTION="launch a sandboxed shell ... useful for debugging ebuilds"
HOMEPAGE="http://wh0rd.org/"
SRC_URI=""

LICENSE="public-domain"
SLOT="0"
# if portage works, this will work ;)
KEYWORDS="x86 amd64 alpha arm hppa mips ppc sparc"

DEPEND=""
RDEPEND="sys-apps/portage
	app-shells/bash"

S=${WORKDIR}

src_install() {
	dobin ${FILESDIR}/sandboxshell
	domain ${FILESDIR}/sandboxshell.1
	insinto /etc
	doins ${FILESDIR}/sandboxshell.conf
}
