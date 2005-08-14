# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/ntfsprogs/ntfsprogs-1.9.4.ebuild,v 1.3 2005/08/14 10:03:22 hansmi Exp $

DESCRIPTION="User tools for NTFS filesystems"
HOMEPAGE="http://linux-ntfs.sourceforge.net/"
SRC_URI="mirror://sourceforge/linux-ntfs/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="gnome"

RDEPEND="gnome? ( >=dev-libs/glib-2.0
	>=gnome-base/gnome-vfs-2.0 )"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_compile() {
	econf $(use_enable gnome gnome-vfs) || die "Configure failed"
	emake || die "Make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "Install failed"
	dodoc AUTHORS CREDITS ChangeLog NEWS README TODO.* \
		doc/attribute_definitions doc/*.txt doc/tunable_settings
}
