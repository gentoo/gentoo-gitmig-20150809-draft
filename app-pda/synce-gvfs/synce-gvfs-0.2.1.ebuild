# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/synce-gvfs/synce-gvfs-0.2.1.ebuild,v 1.2 2009/01/21 11:04:34 mescalinum Exp $

inherit fdo-mime gnome2-utils

DESCRIPTION="SynCE - Gnome GVFS extensions"
HOMEPAGE="http://sourceforge.net/projects/synce/"
LICENSE="MIT"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

synce_PV="0.13"

gvfs_PV="1.0.3"
gvfs_P="gvfs-${gvfs_PV}"
gvfs_S="${WORKDIR}/${gvfs_P}"

SRC_URI="mirror://sourceforge/synce/${P}.tar.gz
	mirror://gnome/sources/gvfs/${gvfs_PV%.*}/${gvfs_P}.tar.gz"

RDEPEND=">=gnome-base/${gvfs_P}
		=app-pda/synce-libsynce-${synce_PV}*
		=app-pda/synce-librapi2-${synce_PV}*"
DEPEND="dev-util/gtk-doc
	${RDEPEND}"

RESTRICT="test"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}
