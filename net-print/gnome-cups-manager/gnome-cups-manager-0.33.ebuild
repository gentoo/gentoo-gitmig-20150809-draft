# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/gnome-cups-manager/gnome-cups-manager-0.33.ebuild,v 1.2 2008/06/10 17:11:23 mr_bones_ Exp $

inherit eutils gnome2 flag-o-matic

DESCRIPTION="GNOME CUPS Printer Management Interface"
HOMEPAGE="http://www.gnome.org/"

SRC_URI="${SRC_URI}
	mirror://gentoo/${PN}-patches-${PV}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND=">=x11-libs/gtk+-2.3.1
	>=dev-libs/glib-2.3.1
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2.2
	>=gnome-base/libglade-2
	>=gnome-base/libbonobo-2
	>=net-print/libgnomecups-0.2.3
	gnome-base/gnome-keyring
	>=dev-util/pkgconfig-0.9
	>=dev-util/intltool-0.28"
RDEPEND="${DEPEND}
	x11-libs/gksu"

DOCS="ChangeLog NEWS README"

src_unpack() {
	gnome2_src_unpack
	cd ${S}

	export	EPATCH_SOURCE="${WORKDIR}/patches" \
		EPATCH_SUFFIX="patch" \
		EPATCH_MULTI_MSG="Applying Ubuntu patches (enhancements) ..."
	epatch
}

src_install() {
	gnome2_src_install
	#Debian-specific.
	rm "${D}"/usr/sbin/gnome-cups-switch
}
