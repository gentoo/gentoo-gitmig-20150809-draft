# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/cpulimit/cpulimit-9999.ebuild,v 1.1 2011/10/16 09:42:28 hwoarang Exp $

EAPI="3"
inherit subversion eutils toolchain-funcs

DESCRIPTION="Limits the CPU usage of a process"
HOMEPAGE="http://cpulimit.sourceforge.net"
SRC_URI=""
ESVN_REPO_URI="https://cpulimit.svn.sourceforge.net/svnroot/cpulimit/trunk"
ESVN_PROJECT="cpulimit"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""

src_prepare() {
	epatch "${FILESDIR}/${P}-cflags.patch"
}

src_compile() {
	emake CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	dosbin ${PN} || die
	doman "${FILESDIR}/${PN}.8"
}
