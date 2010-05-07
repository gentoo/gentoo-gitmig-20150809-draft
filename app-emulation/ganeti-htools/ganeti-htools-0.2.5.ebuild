# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/ganeti-htools/ganeti-htools-0.2.5.ebuild,v 1.1 2010/05/07 21:16:08 ramereth Exp $

EAPI="2"

inherit multilib

DESCRIPTION="Cluster tools for fixing common allocation problems on Ganeti 2.0
clusters."
HOMEPAGE="http://code.google.com/p/ganeti/"
SRC_URI="http://ganeti.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-lang/ghc
	dev-haskell/json
	dev-haskell/curl
	dev-haskell/network"
RDEPEND="${DEPEND}"

src_prepare() {
	# htools does not currently compile cleanly with ghc-6.12+, so remove this
	# for now
	sed -i -e "s:-Werror ::" Makefile
}

src_compile() {
	emake -j1 || die "emake failed"
}

src_install() {
	dosbin hspace hscan hbal
	exeinto /usr/$(get_libdir)/ganeti/iallocators
	doexe hail
	doman *.1
	dodoc README NEWS AUTHORS
}
