# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/metacity/metacity-2.6.5.ebuild,v 1.9 2004/11/05 02:54:32 obz Exp $

inherit gnome2 toolchain-funcs

DESCRIPTION="Gnome default windowmanager"
HOMEPAGE="http://www.gnome.org/"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="x86 ppc ~alpha sparc ~hppa ~amd64 ~ia64 mips"
IUSE=""

# not parallel-safe; see bug #14405
MAKEOPTS="${MAKEOPTS} -j1"

# sharp gtk dep is for a certain speed patch
RDEPEND="virtual/x11
	>=x11-libs/pango-1.2
	>=x11-libs/gtk+-2.2.0-r1
	>=gnome-base/gconf-2
	>=x11-libs/startup-notification-0.4"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.29"

DOCS="AUTHORS COPYING ChangeLog HACKING INSTALL NEWS README"

src_unpack(){

	unpack ${A}

	# causes ICE on ppc w/ gcc (still)
	cd ${S}
	if use ppc; then
		if [ gcc-version != "2.95" ] ; then
			patch -p0 < ${FILESDIR}/metacity-2.4.3-ppc-gcc3.2.diff || die "patch failed"
		fi
	fi
}
