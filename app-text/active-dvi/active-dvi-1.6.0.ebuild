# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/active-dvi/active-dvi-1.6.0.ebuild,v 1.3 2005/03/18 16:49:58 mattam Exp $

inherit eutils

MY_PN=${PN/ctive-/}
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="A DVI previewer and a presenter for slides written in LaTeX"
SRC_URI="ftp://ftp.inria.fr/INRIA/Projects/cristal/${MY_PN}/${MY_P}.tgz"
HOMEPAGE="http://pauillac.inria.fr/advi/"
LICENSE="LGPL-2.1"

IUSE="cjk tcltk"
SLOT="0"
KEYWORDS="~x86 ~ppc"

DEPEND=">=dev-lang/ocaml-3.04
	>=dev-ml/camlimages-2.20
	virtual/tetex
	virtual/ghostscript"
RDEPEND="${DEPEND}
	cjk? ( media-fonts/kochi-substitute )"

DOCS="README TODO"

pkg_setup() {

	# warn those who have USE="tcltk" but no ocaml tcltk support
	# because we cant force ocaml to be build with tcltk.
	if use tcltk; then
		if [ ! -d /usr/lib/ocaml/labltk ]; then

			echo ""
			ewarn "You have requested tcltk support, but it appears"
			ewarn "your ocaml wasnt compiled with tcltk support, "
			ewarn "so it can't be included for active-dvi."
			echo ""
			ewarn "Please stop this build, and emerge ocaml with "
			ewarn "USE=\"tcltk\" ocaml"
			ewarn "before emerging active-dvi if you want tcltk support."
			echo ""
			# give the user some time to read this, but leave the
			# choice up to them
			epause 8

		fi
	fi

}

src_unpack() {

	unpack ${A}
	# need to remove texhash, it'll cause problems with
	# the sandbox if we try and run it during emerge
	sed -i -e "s/texhash//" ${S}/Makefile

	if use cjk ; then
		local fp=/usr/X11R6/lib/X11/fonts/truetype
		sed -i -e "s%msmincho.ttc%${fp}/kochi-mincho-subst.ttf%g" \
			-e "s%msgothic.ttc%${fp}/kochi-gothic-subst.ttf%g" \
			${S}/conf/jpfonts.conf
	fi

}

src_compile() {

	econf --with-camlimages=/usr/lib/ocaml/site-packages/camlimages || die
	emake || die
	#emake -j1 || emake -j1 || emake -j1 || die

}

src_install() {

	TEXMFADVI="/usr/share/texmf/tex/latex/advi"

	dodir /usr/bin $TEXMFADVI
	make MANDIR=${D}/usr/share/man/man1 \
		ADVI_LOC=${D}/${TEXMFADVI} \
		prefix=${D}/usr install || die

	# only include the jpfonts.config if use cjk
	use cjk || rm ${D}${TEXMFADVI}/jpfonts.conf

	# now install the documentation
	dodoc ${DOCS}
	cd ${S}/doc
	dohtml *.{jpg,gif,css,html}
	dodoc manual.{dvi,pdf,ps}
	# and the manual page
	doman advi.1

}

pkg_postinst() {

	if use cjk; then

		echo ""
		einfo "If you wish to use Japanese True Type fonts with"
		einfo "active-dvi, please edit /usr/share/texmf/tex/latex/advi/jpfonts.conf"
		echo ""

	fi

}
