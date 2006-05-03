# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/coq/coq-8.0-r1.ebuild,v 1.5 2006/05/03 01:10:42 weeve Exp $

inherit eutils

IUSE="norealanalysis ide debug translator doc"

RESTRICT="nostrip"

MY_PV="8.0pl1"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="Coq is a proof assistant written in O'Caml"
HOMEPAGE="http://coq.inria.fr/"
SRC_URI="ftp://ftp.inria.fr/INRIA/${PN}/V${MY_PV/_/}/${MY_P/_/}.tar.gz
translator? ( ftp://ftp.inria.fr/INRIA/coq/V${MY_PV}/${MY_P}-translator.tar.gz )"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ppc sparc x86"

DEPEND=">=dev-lang/ocaml-3.06
ide? ( >=dev-ml/lablgtk-2.2.0 )"

S="${WORKDIR}/${MY_P/_/}"

src_unpack()
{
	unpack ${A}
	cd ${S}
	version=`ocamlc -v | grep 3.08.1`
	if [ $? -eq 0 ]
	then
		epatch ${FILESDIR}/${P}-ocaml-3.08.1.patch
	fi
	epatch ${FILESDIR}/${P}-byteflags.patch
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
