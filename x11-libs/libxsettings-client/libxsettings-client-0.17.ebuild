# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libxsettings-client/libxsettings-client-0.17.ebuild,v 1.8 2012/02/21 16:15:04 ago Exp $

GPE_TARBALL_SUFFIX="bz2"

inherit gpe autotools

DESCRIPTION="XSETTINGS client code"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 arm ~hppa ppc ~sh x86"

DOCS="ChangeLog"
IUSE=""

RDEPEND="${RDEPEND}"

DEPEND="${DEPEND}
	${RDEPEND}
	x11-proto/xproto
	x11-libs/libX11"

src_unpack() {
	gpe_src_unpack "$@"

	sed -i -e \
		's;INCLUDES = -I $(includedir);INCLUDES = -I '$ROOT'/$(includedir);' \
		Makefile.am || die "sed failed"
	sed -i -e '/^CFLAGS="-Os -Wall"/d' configure.ac || die "sed failed"
	eautoreconf
}
