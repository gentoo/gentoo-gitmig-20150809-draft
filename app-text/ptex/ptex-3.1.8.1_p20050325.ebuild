# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/ptex/ptex-3.1.8.1_p20050325.ebuild,v 1.2 2005/04/02 06:44:50 usata Exp $

TETEX_PV=3.0
TEXMF_PATH=/var/lib/texmf

inherit tetex eutils

DESCRIPTION="The ASCII publishing TeX distribution"
HOMEPAGE="http://www.ascii.co.jp/pb/ptex/
	http://www.misojiro.t.u-tokyo.ac.jp/~tutimura/ptetex3/0README
	http://www.fsci.fuk.kindai.ac.jp/aftp/pub/ptex/utils/"

PTEX_TEXMF_PV=2.3
PTEX_SRC="ptex-src-${PV%_*}.tar.gz"
PTEX_TEXMF="ptex-texmf-${PTEX_TEXMF_PV}.tar.gz"
PTETEX=ptetex3-${PV//*_p}

S=${WORKDIR}/tetex-src-${TETEX_PV}

SRC_PATH_PTEX="ftp://ftp.ascii.co.jp/pub/TeX/ascii-ptex"
SRC_PATH_TETEX="ftp://cam.ctan.org/tex-archive/systems/unix/teTeX/current/distrib"
TETEX_SRC="tetex-src-${TETEX_PV}.tar.gz"
TETEX_TEXMF="tetex-texmf-${TETEX_PV}.tar.gz"
TETEX_TEXMF_SRC=""
SRC_URI="${SRC_PATH_TETEX}/${TETEX_SRC}
	${SRC_PATH_TETEX}/${TETEX_TEXMF}
	http://www.misojiro.t.u-tokyo.ac.jp/~tutimura/ptetex3/${PTETEX}.tar.gz
	mirror://gentoo/tetex-${TETEX_PV}-gentoo.tar.gz"

LICENSE="GPL-2 BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~ppc-macos ~sparc ~x86"
IUSE="X motif lesstif Xaw3d neXt"

DEPEND="X? ( >=media-libs/freetype-2
		>=media-fonts/kochi-substitute-20030809-r3
		motif? ( lesstif? ( x11-libs/lesstif )
			!lesstif? ( x11-libs/openmotif ) )
		!motif? ( neXt? ( x11-libs/neXtaw )
			!neXt? ( Xaw3d? ( x11-libs/Xaw3d ) ) )
		!app-text/xdvik
	)
	!dev-tex/memoir
	!dev-tex/lineno
	!dev-tex/SIunits
	!dev-tex/floatflt
	!dev-tex/g-brief
	!dev-tex/pgf
	!dev-tex/xcolor
	!dev-tex/xkeyval"

src_unpack() {
	unpack ${PTETEX}.tar.gz
	tetex_src_unpack

	einfo "Unpacking pTeX sources ..."
	cd ${S}/texmf
	echo ">>> Unpacking ${PTEX_TEXMF} to ${S}/texmf ..."
	tar xzf ${WORKDIR}/${PTETEX}/archive/${PTEX_TEXMF} || die

	cd ${S}/texk/web2c
	echo ">>> Unpacking ${PTEX_SRC} to ${S}/texk/web2c ..."
	tar xzf ${WORKDIR}/${PTETEX}/archive/${PTEX_SRC} || die

	cd ${S}/texk
	echo ">>> Unpacking dvipsk-jpatch to ${S}/texk ..."
	tar xzf ${WORKDIR}/${PTETEX}/archive/dvipsk-*.tar.gz || die
	epatch dvipsk-*.patch

	if use X ; then
		cd ${S}
		epatch ${WORKDIR}/${PTETEX}/archive/xdvik-*.diff.gz
		cat >>${S}/texk/xdvik/vfontmap.sample<<-EOF

		# TrueType fonts
		min     /usr/share/fonts/kochi-substitute/kochi-mincho-subst.ttf
		nmin    /usr/share/fonts/kochi-substitute/kochi-mincho-subst.ttf
		goth    /usr/share/fonts/kochi-substitute/kochi-gothic-subst.ttf
		tmin    /usr/share/fonts/kochi-substitute/kochi-mincho-subst.ttf
		tgoth   /usr/share/fonts/kochi-substitute/kochi-gothic-subst.ttf
		ngoth   /usr/share/fonts/kochi-substitute/kochi-gothic-subst.ttf
		jis     /usr/share/fonts/kochi-substitute/kochi-mincho-subst.ttf
		jisg    /usr/share/fonts/kochi-substitute/kochi-gothic-subst.ttf
		dm      /usr/share/fonts/kochi-substitute/kochi-mincho-subst.ttf
		dg      /usr/share/fonts/kochi-substitute/kochi-gothic-subst.ttf
		mgoth   /usr/share/fonts/kochi-substitute/kochi-gothic-subst.ttf
		fmin    /usr/share/fonts/kochi-substitute/kochi-mincho-subst.ttf
		fgoth   /usr/share/fonts/kochi-substitute/kochi-gothic-subst.ttf
		EOF
	fi
}

src_compile() {
	sed -i -e "/mktexlsr/,+3d" -e "s/\(updmap-sys\)/\1 --nohash/" Makefile.in || die

	if use X ; then
		export CPPFLAGS="${CPPFLAGS} -I/usr/include/freetype2"

		if use motif ; then
			if use lesstif ; then
				append-ldflags -L/usr/X11R6/lib/lesstif -R/usr/X11R6/lib/lesstif
				export CPPFLAGS="${CPPFLAGS} -I/usr/X11R6/include/lesstif"
			fi
			toolkit="motif"
		elif use neXt ; then
			toolkit="neXtaw"
		elif use Xaw3d ; then
			toolkit="xaw3d"
		else
			toolkit="xaw"
		fi

		TETEX_ECONF="--with-vflib=vf2ft --enable-freetype --with-xdvi-x-toolkit=${toolkit}"
	fi

	tetex_src_compile

	# make ptex.tex visible to ptex
	TEXMF="${S}/texmf" ${S}/texk/kpathsea/mktexlsr || die

	cd ${S}/texk/web2c/${PTEX_SRC%.tar.gz} || die
	chmod +x configure
	./configure EUC || die "configure pTeX failed"

	make || die "make pTeX failed"
}

src_install() {
	addwrite /var/cache/fonts
	addwrite /var/lib/texmf
	addwrite /usr/share/texmf
	tetex_src_install base doc fixup

	einfo "Installing pTeX ..."
	dodir ${TEXMF_PATH}/web2c
	cd ${S}/texk/web2c/${PTEX_SRC%.tar.gz} || die
	einstall bindir=${D}/usr/bin texmf=${D}${TEXMF_PATH} || die

	# ptex reinstalls ${TEXMF_PATH}/web2c
	tetex_src_install link

	insinto /usr/share/texmf/fonts/map/dvips/tetex
	doins ${FILESDIR}/psfonts-ja.map || die
	insinto /etc/texmf/updmap.d
	doins ${FILESDIR}/20updmap-ja.cfg
	insinto /etc/texmf/fmtutil.d
	doins ${FILESDIR}/20fmtutil-platex.cnf
	insinto /etc/texmf/texmf.d
	doins ${FILESDIR}/20texmf-cmap.cnf

	docinto dvipsk
	cd ${S}/texk/dvipsk
	dodoc ../ChangeLog.jpatch ../README.jpatch

	if use X ; then
		cd ${S}/texk/xdvik
		docinto xdvik
		dodoc ANNOUNCE BUGS CHANGES.xdvik-jp FAQ README.*
		docinto xdvik/READMEs
		dodoc READMEs/*
	fi
}
