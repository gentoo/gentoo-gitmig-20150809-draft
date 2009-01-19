# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/ntfsprogs/ntfsprogs-2.0.0-r1.ebuild,v 1.4 2009/01/19 00:02:57 vapier Exp $

DESCRIPTION="User tools for NTFS filesystems"
HOMEPAGE="http://www.linux-ntfs.org/"
SRC_URI="mirror://sourceforge/linux-ntfs/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="crypt debug fuse gnome minimal"

RDEPEND="dev-libs/libconfig
	fuse? ( >=sys-fs/fuse-2.7.0 )
	crypt? ( >=dev-libs/libgcrypt-1.2.0 >=net-libs/gnutls-1.2.8 )
	gnome? (
		>=dev-libs/glib-2.0
		>=gnome-base/gnome-vfs-2.0
	)"
DEPEND="${RDEPEND}
	!=sys-fs/ntfs3g-0.1_beta20070714
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	#epatch "${FILESDIR}"/${P}-extras.patch #218601
	use minimal || sed -i 's:^EXTRA_PROGRAMS =:bin_PROGRAMS +=:' ntfsprogs/Makefile.in #218601
	sed -i \
		-e '/CFLAGS/s:-ggdb3\>::' \
		-e '/CFLAGS/s:-O0\>::' \
		configure || die
}

src_compile() {
	econf \
		$(use_enable crypt crypto) \
		$(use_enable debug) \
		$(use_enable fuse ntfsmount) \
		$(use_enable gnome gnome-vfs) \
		|| die "Configure failed"
	emake || die "Make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	mv "${D}"/sbin/mkfs.ntfs "${D}"/usr/sbin/ || die
	if ! use minimal ; then
		mv "${D}"/usr/bin/ntfsck "${D}"/sbin/ || die
		dosym ntfsck /sbin/fsck.ntfs
	fi
	if use fuse ; then
		mv "${D}"/sbin/mount.{fuse.ntfs,ntfs-fuse} "${D}"/usr/bin/ || die
	fi

	dodoc AUTHORS CREDITS ChangeLog NEWS README TODO.* \
		doc/attribute_definitions doc/*.txt doc/tunable_settings
}
