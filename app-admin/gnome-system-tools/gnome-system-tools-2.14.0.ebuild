# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/gnome-system-tools/gnome-system-tools-2.14.0.ebuild,v 1.1 2006/03/17 21:00:09 joem Exp $

inherit gnome2 eutils

DESCRIPTION="Tools aimed to make easy the administration of UNIX systems"
HOMEPAGE="http://www.gnome.org/projects/gst/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="nfs samba"

RDEPEND="net-misc/openssh
	userland_GNU? ( sys-apps/shadow )
	>=x11-libs/gtk+-2.6
	>=gnome-base/libgnomeui-2.9.0
	>=gnome-base/libglade-2.4
	>=gnome-base/gconf-2.2
	>=dev-libs/libxml2-2.4.12
	>=gnome-base/nautilus-2.9.90
	>=app-admin/system-tools-backends-1.3.0
	nfs? ( net-fs/nfs-utils )
	samba? ( >=net-fs/samba-3 )"

DEPEND="${RDEPEND}
	app-text/scrollkeeper
	dev-util/pkgconfig
	>=dev-util/intltool-0.29"

DOCS="AUTHORS BUGS ChangeLog HACKING NEWS README TODO"

# --enable-disks is not (still) supported for Gentoo
G2CONF="${G2CONF} --enable-boot --enable-services --disable-network"

pkg_setup() {

	if ! use nfs && ! use samba; then
		G2CONF="${G2CONF} --disable-shares"
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}

	gnome2_omf_fix
}
