# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/passook/passook-1.0.0.ebuild,v 1.24 2010/04/12 18:17:04 gmsoft Exp $

EAPI="3"

inherit eutils prefix

S=${WORKDIR}
DESCRIPTION="Password generator capable of generating pronounceable and/or secure passwords."
SRC_URI="http://mackers.com/projects/passook/${PN}.tar.gz"
HOMEPAGE="http://mackers.com/misc/scripts/passook/"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 hppa ppc ppc64 sparc x86 ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos"
IUSE=""

DEPEND="dev-lang/perl
	sys-apps/grep
	sys-apps/miscfiles"

src_prepare() {
	epatch "${FILESDIR}"/passook.patch
	eprefixify passook
}

src_install() {
	dobin passook || die "dobin failed"
	dodoc README passook.cgi
}
