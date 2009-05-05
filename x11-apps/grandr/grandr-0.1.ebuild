# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/grandr/grandr-0.1.ebuild,v 1.6 2009/05/05 07:31:16 fauli Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="GTK+-based tool to configure the X output using the RandR 1.2 extension"
KEYWORDS="~amd64 ppc x86"
LICENSE="MIT"
IUSE=""
RDEPEND="=x11-libs/gtk+-2*
	>=x11-libs/libXrandr-1.2
	gnome-base/gconf"
DEPEND="${RDEPEND}"
PATCHES=( "${FILESDIR}"/${PV}-fix-license-display.patch
	"${FILESDIR}"/${PV}-outpus.patch
	"${FILESDIR}"/${PV}-fix-segfault-without-gconf-value.patch )

src_install() {
	x-modular_src_install
	dodoc NEWS
}
