# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/synce-gnomevfs/synce-gnomevfs-0.12.ebuild,v 1.2 2008/11/17 18:34:26 mescalinum Exp $

DESCRIPTION="SynCE - Gnome VFS extensions"
HOMEPAGE="http://sourceforge.net/projects/synce/"
LICENSE="MIT"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="debug"
DEPEND=">=gnome-base/gnome-vfs-2.0
		~app-pda/synce-libsynce-0.12
		~app-pda/synce-librapi2-0.12"

SRC_URI="mirror://sourceforge/synce/${P}.tar.gz"

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README TODO
}
