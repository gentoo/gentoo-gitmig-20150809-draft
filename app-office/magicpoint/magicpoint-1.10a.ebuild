# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/magicpoint/magicpoint-1.10a.ebuild,v 1.1 2003/12/15 17:47:45 usata Exp $

inherit elisp-common eutils

IUSE="cjk emacs truetype gif nls imlib"

DESCRIPTION="an X11 based presentation tool"
SRC_URI="ftp://ftp.mew.org/pub/MagicPoint/${P}.tar.gz"
HOMEPAGE="http://www.mew.org/mgp/"

SLOT="0"
LICENSE="BSD"
KEYWORDS="x86 ~alpha ~sparc ~ppc"

DEPEND="virtual/x11
	gif? ( >=media-libs/libungif-4.0.1 )
	imlib? ( media-libs/imlib )
	cjk? ( truetype? ( >=media-libs/vflib-2.25.6-r1 )
		: ( =media-libs/freetype-1* ) )
	truetype? ( =media-libs/freetype-1* )
	emacs? ( virtual/emacs )"
RDEPEND="${DEPEND}
	nls? ( sys-devel/gettext )"

S=${WORKDIR}/${P}
SITELISP=/usr/share/emacs/site-lisp
SITEFILE=50mgp-mode-gentoo.el

src_unpack() {

	unpack ${A}
	epatch ${FILESDIR}/${P}-gentoo.diff
}

src_compile() {

	local myconf

	if [ -n "`use cjk`" -a -n "`use truetype`" ] ; then
		myconf="--enable-vflib
			--with-vfontcap=/usr/share/VFlib/2.25.6/vfontcap.mgp"
	else
		myconf="--disable-vflib
			`use_enable cjk freetype-charset16`
			`use_enable truetype freetype`"
	fi

	econf \
		`use_enable gif` \
		`use_enable imlib` \
		`use_enable nls locale` \
		--disable-xft2 \
		${myconf} || die

	xmkmf || die
	make Makefiles || die
	make clean || die
	make || die
}

src_install() {

	make \
		DESTDIR=${D} \
		install || die

	make \
		DESTDIR=${D} \
		DOCHTMLDIR=/usr/share/doc/${P} \
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
