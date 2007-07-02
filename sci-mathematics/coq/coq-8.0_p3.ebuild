# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/coq/coq-8.0_p3.ebuild,v 1.6 2007/07/02 15:26:46 peper Exp $

inherit eutils

IUSE="norealanalysis ide debug translator doc"

RESTRICT="strip"

MY_PV="${PV/_p/pl}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="Coq is a proof assistant written in O'Caml"
HOMEPAGE="http://coq.inria.fr/"
SRC_URI="ftp://ftp.inria.fr/INRIA/${PN}/V${MY_PV}/${MY_P}.tar.gz
mirror://gentoo/${P}-ocaml-3.09.patch.gz
translator? ( ftp://ftp.inria.fr/INRIA/coq/V${MY_PV}/${MY_P}-translator.tar.gz )"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"

DEPEND=">=dev-lang/ocaml-3.08
ide? ( >=dev-ml/lablgtk-2.2.0 )"

S="${WORKDIR}/${MY_P}"

src_unpack()
{
	unpack ${A}
	cd ${S}

	if has_version ">=dev-lang/ocaml-3.09";
	then
		epatch ${WORKDIR}/${P}-ocaml-3.09.patch
	fi
}

src_compile() {
	local myconf="--prefix /usr \
		--bindir /usr/bin \
		--libdir /usr/lib/coq \
		--mandir /usr/man \
		--emacslib /usr/share/emacs/site-lisp \
		--coqdocdir /usr/lib/coq/coqdoc"

	use debug && myconf="--debug $myconf"
	use norealanalysis && myconf="$myconf --reals"
	use norealanalysis || myconf="$myconf --reals all"

	if use ide; then
		myconf="$myconf --coqide opt"
	else
		myconf="$myconf --coqide no"
	fi

	./configure $myconf || die

	if use ide; then
		labldir=/usr/lib/ocaml/lablgtk2
		sed -i -e "s|BYTEFLAGS=|BYTEFLAGS=-I ${labldir} |" Makefile
		sed -i -e "s|OPTFLAGS=|OPTFLAGS=-I ${labldir} |" Makefile
		sed -i -e "s|COQIDEFLAGS=.*|COQIDEFLAGS=-thread -I ${labldir}|" Makefile
		make world || die
	else
		make world
	fi
}

src_install() {
	make COQINSTALLPREFIX=${D} install || die
	dodoc README CREDITS CHANGES LICENSE

	if use translator; then
		cd ${WORKDIR}/${MY_P}-translator
		mv translate-v8 coq-translate-v8
		dobin coq-translate-v8
		if use doc; then
			dodoc Translator.* syntax-v8.*
		fi
	fi

	if use ide; then
		insinto /usr/share/applnk/Edutainment/Mathematics
		doins ${FILESDIR}/coqide.desktop
	fi
}
