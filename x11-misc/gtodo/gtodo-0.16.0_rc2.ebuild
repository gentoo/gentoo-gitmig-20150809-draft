# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/gtodo/gtodo-0.16.0_rc2.ebuild,v 1.1 2007/02/12 17:10:10 drac Exp $

inherit gnome2 versionator

MY_P=${PN}-$(replace_version_separator 3 '-' )

DESCRIPTION="Gnome Task List Manager is a GTK+ based TODO application with applet."
HOMEPAGE="http://cms.qballcow.nl/index.php?page=Gnome_Task_List_Manager"
SRC_URI="http://download.qballcow.nl/programs/${PN}/${MY_P}.tar.gz
	gnome? ( http://download.qballcow.nl/programs/${PN}/${PN}-applet-0.16-2.tar.gz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE="gnome"

RDEPEND=">=x11-libs/gtk+-2.4
	>=dev-libs/libxml2-2.5.8
	>=gnome-base/gconf-2
	>=dev-libs/glib-2
	>=gnome-base/gnome-vfs-2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext
	dev-libs/libxslt"

S="${WORKDIR}/${P/_rc2/}"

DOCS="AUTHORS ChangeLog NEWS README"

src_compile(){
	econf
	emake || die "emake failed"

	if use gnome; then
		cd "${WORKDIR}/${PN}-applet-0.16-2"
		econf
		emake || die "emake failed."
	fi
}

src_install(){
	addwrite /etc/gconf
	emake DESTDIR="${D}" install || die "emake install failed."

	if use gnome; then
		cd "${WORKDIR}/${PN}-applet-0.16-2"
		emake DESTDIR="${D}" install || die "emake install failed."
	fi
}
