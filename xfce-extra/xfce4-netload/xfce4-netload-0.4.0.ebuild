# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-netload/xfce4-netload-0.4.0.ebuild,v 1.20 2009/08/23 16:56:03 ssuominen Exp $

inherit xfce44 eutils autotools

xfce44

DESCRIPTION="Netload panel plugin"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""
DEPEND=">=dev-util/xfce4-dev-tools-${XFCE_MASTER_VERSION}
	dev-util/intltool"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-asneeded.patch
	sed -i -e "/^AC_INIT/s/netload_version()/netload_version/" configure.ac \
		|| die "sed failed"
	intltoolize --force --copy --automake || die "intltoolize failed."
	AT_M4DIR=/usr/share/xfce4/dev-tools/m4macros eautoreconf
}

xfce44_goodies_panel_plugin
