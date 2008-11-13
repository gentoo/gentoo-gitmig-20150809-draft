# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/synce-gvfs/synce-gvfs-0.1.ebuild,v 1.2 2008/11/13 16:50:59 mescalinum Exp $

DESCRIPTION="SynCE - Gnome GVFS extensions"
HOMEPAGE="http://sourceforge.net/projects/synce/"
LICENSE="MIT"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="=gnome-base/gvfs-0.2*
		~app-pda/synce-libsynce-0.12
		~app-pda/synce-librapi2-0.12"
RDEPEND="${DEPEND}"

SRC_URI="mirror://sourceforge/synce/${P}.tar.gz"

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README TODO
}
