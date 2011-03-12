# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/ganeti-htools/ganeti-htools-0.3.1.ebuild,v 1.1 2011/03/12 19:11:19 ramereth Exp $

EAPI="2"

inherit multilib

DESCRIPTION="Cluster tools for fixing common allocation problems on Ganeti 2.0
clusters."
HOMEPAGE="http://code.google.com/p/ganeti/"
SRC_URI="http://ganeti.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND="dev-lang/ghc
	dev-haskell/json
	dev-haskell/curl
	dev-haskell/network
	dev-haskell/parallel"
RDEPEND="${DEPEND}
	!<app-emulation/ganeti-2.4"

src_prepare() {
	# htools does not currently compile cleanly with ghc-6.12+, so remove this
	# for now
	sed -i -e "s:-Werror ::" Makefile
	# Workaround to skip pandoc
	sed -i -e "s:) man:):" Makefile
}

src_compile() {
	emake -j1 || die "emake failed"
}

src_install() {
	dosbin hspace hscan hbal
	exeinto /usr/$(get_libdir)/ganeti/iallocators
	doexe hail
	doman man/*.1
	dodoc README NEWS AUTHORS
	use doc && dohtml -r apidoc/*
}
