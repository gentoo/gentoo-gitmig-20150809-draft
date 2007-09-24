# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/magicpoint/magicpoint-1.12a.ebuild,v 1.3 2007/09/24 20:14:21 opfer Exp $

inherit autotools elisp-common eutils fixheadtails

DESCRIPTION="an X11 based presentation tool"
SRC_URI="ftp://sh.wide.ad.jp/WIDE/free-ware/mgp/${P}.tar.gz
	ftp://ftp.mew.org/pub/MagicPoint/${P}.tar.gz"
HOMEPAGE="http://member.wide.ad.jp/wg/mgp/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~alpha ~sparc ~ppc ~amd64"
IUSE="cjk nls m17n-lib emacs truetype gif imlib"

MY_DEPEND="x11-libs/libICE
	x11-libs/libSM
	x11-libs/libXrender
	x11-libs/libXmu
	gif? ( >=media-libs/giflib-4.0.1 )
	imlib? ( media-libs/imlib )
	truetype? ( virtual/xft )
	emacs? ( virtual/emacs )
	m17n-lib? ( dev-libs/m17n-lib )
	g? ( media-libs/libmng )"
DEPEND="${MY_DEPEND}
	sys-devel/autoconf
	x11-proto/xextproto
	x11-libs/libxkbfile
	app-text/rman
	x11-misc/imake"
RDEPEND="${MY_DEPEND}
	nls? ( sys-devel/gettext )
	truetype? ( cjk? ( media-fonts/sazanami ) )"

SITEFILE=50${PN}-gentoo.el

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PN}-1.11b-gentoo.diff"

	# bug #85720
	sed -i -e "s/ungif/gif/g" configure.in || die "sed failed"
	ht_fix_file configure.in
	eautoreconf
}

src_compile() {
	econf \
		$(use_enable gif) \
		$(use_enable imlib) \
		$(use_enable nls locale) \
		$(use_enable truetype xft2) \
		$(use_with m17n-lib) \
		--disable-vflib \
		--disable-freetype \
		--x-libraries=/usr/X11R6/lib \
		--x-includes=/usr/X11R6/include || die "econf failed"

	xmkmf || die "xmkmf failed"
	# emake fails miserably at all that
	make Makefiles || die "make failed"
	make clean || die "make clean failed"
	make BINDIR=/usr/bin LIBDIR=/etc/X11 || die "make failed"
	use emacs && cp contrib/*.el "${S}" && \
		elisp-compile *.el || die "elisp-compile failed"
}

src_install() {
	make \
		DESTDIR="${D}" \
		BINDIR=/usr/bin \
		LIBDIR=/etc/X11 \
		install || die "make install failed"

	make \
		DESTDIR="${D}" \
		DOCHTMLDIR=/usr/share/doc/${PF} \
		MANPATH=/usr/share/man \
		MANSUFFIX=1 \
		install.man || die "make install.man failed"

	exeinto /usr/bin
	doexe contrib/{mgp2html.pl,mgp2latex.pl}

	if use emacs ; then
		elisp-install ${PN} *.el *.elc || die "elisp-install failed"
		elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	fi

	dodoc COPYRIGHT* FAQ README* RELNOTES SYNTAX TODO* USAGE*

	insinto /usr/share/${PF}/sample
	cd sample
	doins README* cloud.jpg dad.* embed*.mgp gradation*.mgp \
		mgp-old*.jpg mgp.mng mgp3.xbm mgprc-sample \
		multilingual.mgp sample*.mgp sendmail6*.mgp \
		tutorial*.mgp v6*.mgp v6header.* || die "example installation failed"
}

pkg_postinst() {
	elog
	elog "If you enabled xft2 support (default) you may specify xfont directive by"
	elog "font name and font registry."
	elog "e.g.)"
	elog '%deffont "standard" xfont "sazanami mincho" "jisx0208.1983"'
	elog
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
