# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmhdplop/wmhdplop-0.9.6.ebuild,v 1.2 2004/09/03 15:33:02 dholm Exp $

inherit eutils

IUSE="gkrellm"

DESCRIPTION="A fancy hard drive activity monitor dockapp"
HOMEPAGE="http://hules.free.fr/wmhdplop"
SRC_URI="http://hules.free.fr/wmhdplop/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

DEPEND="virtual/x11
	>=media-libs/imlib2-1.1.0
	gkrellm? ( >=app-admin/gkrellm-2.1.28-r1 )"

src_unpack()
{
	unpack ${A}
	cd ${S}

	# Honour Gentoo CFLAGS, but retain some the package author chose himself
	epatch ${FILESDIR}/${PN}-cflags.patch
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
