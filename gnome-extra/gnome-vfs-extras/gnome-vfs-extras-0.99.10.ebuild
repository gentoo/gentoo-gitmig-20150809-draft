# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-vfs-extras/gnome-vfs-extras-0.99.10.ebuild,v 1.10 2004/07/14 15:54:16 agriffis Exp $

inherit gnome2

IUSE=""
DESCRIPTION="the Gnome Virtual Filesystem extra libraries"
HOMEPAGE="http://www.gnome.org/"

SLOT="1"
LICENSE="GPL-2"
KEYWORDS="x86 ~sparc ppc amd64"

RDEPEND=">=gnome-base/gnome-vfs-2.1.5"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.20
	>=dev-util/pkgconfig-0.12.0
	>=sys-devel/autoconf-2.58"

src_unpack() {
	unpack ${A} || die "unpack failed"

	cd ${S}/samba
	export WANT_AUTOCONF=2.5
	autoconf --force
}

DOCS="AUTHORS COPYING ChangeLog INSTALL NEWS  README"
