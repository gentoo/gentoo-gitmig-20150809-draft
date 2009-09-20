# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/hevea/hevea-1.10.ebuild,v 1.4 2009/09/20 15:46:49 aballier Exp $

EAPI="2"

inherit eutils multilib

IUSE="+ocamlopt"

DESCRIPTION="HeVeA is a quite complete and fast LaTeX to HTML translator"
HOMEPAGE="http://pauillac.inria.fr/~maranget/hevea/"
SRC_URI="ftp://ftp.inria.fr/INRIA/moscova/hevea/${P}.tar.gz"

LICENSE="QPL"
SLOT="0"
KEYWORDS="~amd64 ppc ~sparc x86"

DEPEND=">=dev-lang/ocaml-3.10.2[ocamlopt?]"
RDEPEND="${DEPEND}"

src_compile() {
	rm -f config.sh
	emake PREFIX=/usr DESTDIR="${D}" LIBDIR="/usr/$(get_libdir)/hevea" LATEXLIBDIR="/usr/$(get_libdir)/hevea" config.sh || die "Failed to create config.sh"
	if use ocamlopt; then
		emake PREFIX=/usr || die "Failed to build native code binaries"
	else
		emake PREFIX=/usr TARGET=byte || die "Failed to build bytecode binaries"
	fi
}

src_install() {
	if use ocamlopt; then
		emake DESTDIR="${D}" PREFIX=/usr install || die "Install failed"
	else
		emake DESTDIR="${D}" PREFIX=/usr TARGET=byte install || die "Install failed"
	fi

	doenvd "${FILESDIR}"/99hevea

	dodoc README CHANGES
}
