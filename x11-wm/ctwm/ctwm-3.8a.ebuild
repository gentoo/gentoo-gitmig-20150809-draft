# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/ctwm/ctwm-3.8a.ebuild,v 1.2 2010/09/16 15:06:16 jer Exp $

EAPI="2"

inherit eutils toolchain-funcs

DESCRIPTION="A clean, light window manager."
HOMEPAGE="http://ctwm.free.lp.se/"
SRC_URI="http://ctwm.free.lp.se/dist/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXmu
	x11-libs/libXpm
	x11-libs/libXt"
DEPEND="${RDEPEND}
	app-text/rman
	media-libs/jpeg
	x11-misc/imake
	x11-proto/xextproto
	x11-proto/xproto"

src_prepare() {
	sed -i Imakefile \
		-e "s@\(CONFDIR =\).*@\1 /etc/X11/twm@g" \
		|| die "sed Imakefile"

	cp Imakefile.local-template Imakefile.local

	# TODO: Add GNOME support
	sed -i Imakefile.local \
		-e '/^#define GNOME/d' \
		|| die "sed Imakefile.local"
}

src_compile() {
	xmkmf || die "xmkmf failed"
	emake \
		CC=$(tc-getCC) \
		CFLAGS="${CFLAGS}" \
		EXTRA_LDOPTIONS="${LDFLAGS}" \
		TWMDIR=/usr/share/${PN} \
		|| die "emake failed"
}

src_install() {
	make BINDIR=/usr/bin \
		MANPATH=/usr/share/man \
		TWMDIR=/usr/share/${PN} \
		DESTDIR="${D}" install || die "make install failed"

	make MANPATH=/usr/share/man \
		DOCHTMLDIR=/usr/share/doc/${PF}/html \
		DESTDIR="${D}" install.man || die "make install.man failed"

	echo "#!/bin/sh" > ${T}/ctwm
	echo "/usr/bin/ctwm" >> ${T}/ctwm

	exeinto /etc/X11/Sessions
	doexe "${T}"/ctwm

	dodoc CHANGES README* TODO* PROBLEMS
	dodoc *.ctwmrc*
}
