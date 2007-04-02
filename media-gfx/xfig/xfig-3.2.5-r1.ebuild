# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/xfig/xfig-3.2.5-r1.ebuild,v 1.1 2007/04/02 15:23:03 pva Exp $

inherit eutils multilib

MY_P=${PN}.${PV}
DESCRIPTION="A menu-driven tool to draw and manipulate objects interactively in an X window."
HOMEPAGE="http://www.xfig.org"
SRC_URI="http://www.xfig.org/software/xfig/3.2.5/${MY_P}.full.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="|| ( ( x11-libs/libXaw
				x11-libs/libXp )
			virtual/x11 )
	x11-libs/Xaw3d
	media-libs/jpeg
	media-libs/libpng
	>=media-gfx/transfig-3.2.5
	media-libs/netpbm"
DEPEND="${RDEPEND}
	|| ( ( x11-misc/imake
			app-text/rman
			x11-proto/xproto
			x11-proto/inputproto
			x11-libs/libXi )
		virtual/x11 )"

S="${WORKDIR}"/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# We do not have nescape. Let's use firefox instead...
	sed -i "s+netscape+firefox+g" Fig.ad
}

sed_Imakefile() {
	# see Imakefile for details
	vars2subs="BINDIR=/usr/bin
		PNGINC=-I/usr/include
		JPEGLIBDIR=/usr/$(get_libdir)
		JPEGINC=-I/usr/include
		XPMLIBDIR=/usr/$(get_libdir)
		XPMINC=-I/usr/include/X11
		USEINLINE=-DUSE_INLINE
		XFIGLIBDIR=/usr/$(get_libdir)/xfig
		XFIGDOCDIR=/usr/share/doc/${P}
		MANDIR=/usr/share/man/man\$\(MANSUFFIX\)
		CC=$(tc-getCC)"

	for variable in ${vars2subs} ; do
		varname=${variable%%=*}
		varval=${variable##*=}
		sed -i "s:^\(XCOMM\)*[[:space:]]*${varname}[[:space:]]*=.*$:${varname} = ${varval}:" "$@"
	done
}


src_compile() {
	sed_Imakefile Imakefile

	xmkmf || die
	emake CC="$(tc-getCC)" LOCAL_LDFLAGS="${LDFLAGS}" CDEBUGFLAGS="${CFLAGS}" \
	USRLIBDIR=/usr/$(get_libdir) || die
}

src_install() {
	emake -j1 DESTDIR="${D}" install.all || die

	insinto /usr/share/doc/${P}
	doins README FIGAPPS CHANGES LATEX.AND.XFIG
}
