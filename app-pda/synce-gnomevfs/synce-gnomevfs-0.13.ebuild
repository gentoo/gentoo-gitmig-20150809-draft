# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/synce-gnomevfs/synce-gnomevfs-0.13.ebuild,v 1.1 2009/01/21 00:25:39 mescalinum Exp $

DESCRIPTION="SynCE - Gnome VFS extensions"
HOMEPAGE="http://sourceforge.net/projects/synce/"
LICENSE="MIT"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="debug"
DEPEND=">=gnome-base/gnome-vfs-2.0
		~app-pda/synce-libsynce-${PV}
		~app-pda/synce-librapi2-${PV}"
RDEPEND="${DEPEND}"

SRC_URI="mirror://sourceforge/synce/${P}.tar.gz"

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README TODO
}
