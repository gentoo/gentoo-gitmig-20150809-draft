# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/magicpoint/magicpoint-1.10a-r1.ebuild,v 1.2 2004/01/13 05:28:32 genone Exp $

inherit elisp-common eutils

IUSE="cjk emacs truetype gif nls imlib"

DESCRIPTION="an X11 based presentation tool"
SRC_URI="ftp://ftp.mew.org/pub/MagicPoint/${P}.tar.gz"
HOMEPAGE="http://www.mew.org/mgp/"

SLOT="0"
LICENSE="BSD"
KEYWORDS="x86 alpha ~sparc ~ppc"

DEPEND="virtual/x11
	gif? ( >=media-libs/libungif-4.0.1 )
	imlib? ( media-libs/imlib )
	truetype? ( virtual/xft )
	emacs? ( virtual/emacs )"
RDEPEND="${DEPEND}
	nls? ( sys-devel/gettext )
	truetype? ( cjk? ( media-fonts/kochi-substitute ) )"

S=${WORKDIR}/${P}
SITELISP=/usr/share/emacs/site-lisp
SITEFILE=50mgp-mode-gentoo.el

src_unpack() {

	unpack ${A}
	epatch ${FILESDIR}/${PF}-gentoo.diff
}

src_compile() {

	econf \
		`use_enable gif` \
		`use_enable imlib` \
		`use_enable nls locale` \
		`use_enable truetype xft2` \
		--disable-vflib \
		--disable-freetype || die

	xmkmf || die
	make Makefiles || die
	make clean || die
	make BINDIR=/usr/bin LIBDIR=/etc/X11 || die
}

src_install() {

	make \
		DESTDIR=${D} \
		BINDIR=/usr/bin \
		LIBDIR=/etc/X11 \
		install || die

	make \
		DESTDIR=${D} \
		DOCHTMLDIR=/usr/share/doc/${PF} \
		MANPATH=/usr/share/man \
		MANSUFFIX=1 \
		install.man || die

	exeinto /usr/bin
	doexe contrib/{mgp2html.pl,mgp2latex.pl}

	if [ -n "`use emacs`" ] ; then
		insinto ${SITELISP}
		doins contrib/mgp-mode.el ${FILESDIR}/${SITEFILE}
	fi

	insinto /usr/share/${PF}/sample
	cd sample
	doins README* cloud.jpg dad.* embed*.mgp gradation*.mgp \
		mgp-old*.jpg mgp.mng mgp3.xbm mgprc-sample \
		multilingual.mgp sample*.mgp sendmail6*.mgp \
		tutorial*.mgp v6*.mgp v6header.* || die
	cd -

	dodoc COPYRIGHT* FAQ README* RELNOTES SYNTAX TODO* USAGE*
}

pkg_postinst() {

	use emacs && elisp-site-regen
}

pkg_postrm() {

	use emacs && elisp-site-regen
}
