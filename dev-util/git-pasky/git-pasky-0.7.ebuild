# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/git-pasky/git-pasky-0.7.ebuild,v 1.5 2005/05/07 14:09:31 dholm Exp $

inherit eutils

DESCRIPTION="The GIT scripted toolkit"
HOMEPAGE="http://kernel.org/pub/software/scm/cogito/"
SRC_URI="http://kernel.org/pub/software/scm/cogito/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE="mozsha1 ppcsha1"

DEPEND="dev-libs/openssl
	sys-libs/zlib
	!dev-util/git
	!dev-util/cogito"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/Makefile.patch
	epatch "${FILESDIR}"/commit-id.patch
}

src_compile() {
	if use mozsha1 ; then
		export MOZILLA_SHA1=yes
	elif use ppcsha1 ; then
		export PPC_SHA1=yes
	fi

	emake || die "emake failed"
}

src_install() {
	make install DESTDIR="${D}" || die "install failed"
	dodoc README*
}

pkg_postinst() {
	einfo "git-pasky is deprecated in favor of cogito."
	einfo "If you dont really need git-pasky, you should emerge cogito"
}
