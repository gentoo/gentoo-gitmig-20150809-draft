# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmhdplop/wmhdplop-0.9.7-r1.ebuild,v 1.2 2006/10/18 08:49:28 s4t4n Exp $

inherit eutils

IUSE="gkrellm"

DESCRIPTION="A fancy hard drive activity monitor dockapp"
HOMEPAGE="http://hules.free.fr/wmhdplop"
SRC_URI="http://hules.free.fr/wmhdplop/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"

RDEPEND="|| ( (
		x11-libs/libX11
		x11-libs/libXt
		x11-libs/libXext )
	virtual/x11 )
	>=media-fonts/corefonts-1-r2
	>=media-libs/freetype-2.1.10-r2"
DEPEND="${RDEPEND}
	|| ( x11-proto/xextproto virtual/x11 )
	>=media-libs/imlib2-1.2.0-r2
	gkrellm? ( >=app-admin/gkrellm-2.1.28-r1 )"

src_unpack()
{
	unpack ${A}
	cd ${S}

	# Honour Gentoo CFLAGS, but retain some the package author chose himself
	epatch ${FILESDIR}/${PN}-cflags.patch

	# Add corefonts to font path, see bug #139945
	epatch ${FILESDIR}/${PN}-fontpath.patch

	if ! built_with_use media-libs/imlib2 X; then
		echo
		eerror "This package depends on media-libs/imlib2, which needs"
		eerror "to be compiled with 'X' USE flag enabled..."
		echo
		die
	fi
}

src_compile()
{
	econf                           \
		GENTOO_CFLAGS="${CFLAGS}"   \
		`use_enable gkrellm`        \
		|| die "configure failed"

	emake || die "parallel make failed"
}

src_install ()
{
	einstall || die "make install failed"

	dodoc README AUTHORS ChangeLog

	if use gkrellm; then
		# I don't like hardcoded paths, but other
		# gkrellm plugin ebuilds to it the same way...
		exeinto /usr/lib/gkrellm2/plugins/
		doexe gkhdplop.so
	fi
}
