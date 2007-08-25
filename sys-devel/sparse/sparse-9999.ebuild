# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/sparse/sparse-9999.ebuild,v 1.1 2007/08/25 12:40:09 vapier Exp $

EGIT_REPO_URI="git://git.kernel.org/pub/scm/devel/sparse/sparse.git"
inherit eutils multilib git

DESCRIPTION="C semantic parser"
HOMEPAGE="http://kernel.org/pub/linux/kernel/people/josh/sparse/"
SRC_URI=""

LICENSE="OSL-1.1"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND=""

src_unpack() {
	git_src_unpack
	cd "${S}"
	sed -i '/^PREFIX=/s:=.*:=/usr:' Makefile
}

src_install() {
	emake DESTDIR="${D}" LIBDIR="/usr/$(get_libdir)" install || die "make install failed"
	dodoc FAQ README
}
