# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmclockmon/wmclockmon-0.8.0-r1.ebuild,v 1.7 2007/07/11 20:39:22 mr_bones_ Exp $

WANT_AUTOMAKE="1.4"
WANT_AUTOCONF="1.4"

inherit autotools

IUSE="gtk"

DESCRIPTION="digital clock dockapp with seven different styles with a LCD or LED display. Also has a Internet Time feature."
SRC_URI="http://tnemeth.free.fr/projets/programmes/${P}.tar.gz"
HOMEPAGE="http://tnemeth.free.fr/projets/dockapps.html"

SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc x86"
LICENSE="GPL-2"

RDEPEND="gtk? ( =x11-libs/gtk+-1.2* )
	|| ( (
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXpm
		x11-libs/libXdmcp
		x11-libs/libXau )
	virtual/x11 )"

DEPEND="${RDEPEND}
	!gtk? ( >=sys-apps/sed-4.1.4-r1 )
	|| ( (
		x11-proto/xproto
		x11-proto/xextproto )
	virtual/x11 )"

src_compile()
{
	if ! use gtk; then
		econf || die "Configuration failed"
		sed -i 's/doc wmclockmon-config wmclockmon-cal styles/doc styles/' Makefile.am
	fi

	econf || die "Configuration failed"
	emake || die "Compilation failed"
}

src_install ()
{
	einstall || die "make install failed"
	dodoc AUTHORS BUGS ChangeLog THANKS TODO doc/sample.wmclockmonrc
}
