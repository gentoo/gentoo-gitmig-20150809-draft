# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-utils/gnome-utils-2.4.1.ebuild,v 1.12 2005/01/09 11:15:10 slarti Exp $

inherit gnome2

DESCRIPTION="Utilities for the Gnome2 desktop"
HOMEPAGE="http://www.gnome.org/"

IUSE="ipv6"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc alpha sparc hppa amd64 ia64 mips"

RDEPEND=">=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2.2
	>=gnome-base/gnome-desktop-2.2
	>=gnome-base/libglade-2
	>=gnome-base/libbonoboui-2
	>=gnome-base/gnome-vfs-2.4
	>=gnome-base/gnome-panel-2
	>=gnome-base/gconf-1.2.1
	sys-fs/e2fsprogs
	app-text/scrollkeeper
	dev-libs/popt"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.21
	>=dev-util/pkgconfig-0.12.0"

G2CONF="${G2CONF} $(use_enable ipv6)"

DOCS="AUTHORS COPYING ChangeLog INSTALL NEWS README THANKS"

src_compile() {
	gnome2_src_configure

	# This fixes compilation on ia64.  I wish I knew the "right"
	# solution but this will have to do for now.
	# (01 Mar 2004 agriffis)
	if use ia64; then
		sed -i -e 's/^DEFS.*/& -Ds64=__s64 -Du64=__u64 -Ds32=__s32 -Du32=__u32/' \
			gfloppy/src/Makefile || die "ia64 sed failed"
	fi

	emake || die "emake failed"
}
