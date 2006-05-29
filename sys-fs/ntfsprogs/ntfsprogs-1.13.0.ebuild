# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/ntfsprogs/ntfsprogs-1.13.0.ebuild,v 1.7 2006/05/29 21:44:59 blubb Exp $

inherit eutils

DESCRIPTION="User tools for NTFS filesystems"
HOMEPAGE="http://www.linux-ntfs.org/"
SRC_URI="mirror://sourceforge/linux-ntfs/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~sparc x86"
IUSE="crypt debug fuse gnome"

RDEPEND="fuse? ( >=sys-fs/fuse-2.3.0 )
	crypt? ( >=dev-libs/libgcrypt-1.2.0 >=net-libs/gnutls-1.2.8 )
	gnome? (
		>=dev-libs/glib-2.0
		>=gnome-base/gnome-vfs-2.0
	)"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-pkg-config.patch
}

src_compile() {
	sed -i -e 's:-ggdb3::' configure
	econf \
		$(use_enable crypt crypto) \
		$(use_enable debug) \
		$(use_enable fuse fuse-module) \
		$(use_enable gnome gnome-vfs) \
		|| die "Configure failed"
	emake || die "Make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "Install failed"
	dodoc AUTHORS CREDITS ChangeLog NEWS README TODO.* \
		doc/attribute_definitions doc/*.txt doc/tunable_settings
}
