# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/synce-gnomevfs/synce-gnomevfs-0.13.ebuild,v 1.4 2010/07/13 16:59:49 ssuominen Exp $

inherit versionator

synce_PV=$(get_version_component_range 1-2)

DESCRIPTION="SynCE - Gnome VFS extensions"
HOMEPAGE="http://sourceforge.net/projects/synce/"
SRC_URI="mirror://sourceforge/synce/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND=">=gnome-base/gnome-vfs-2.0
	=app-pda/synce-libsynce-${synce_PV}*
	=app-pda/synce-librapi2-${synce_PV}*"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README TODO
}
