# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/captive/captive-1.1.6.ebuild,v 1.1 2005/12/26 19:07:24 genstef Exp $

inherit eutils

DESCRIPTION="Captive uses binary Windows drivers for full NTFS r/w access."
HOMEPAGE="http://www.jankratochvil.net/project/captive/"
SRC_URI="http://www.jankratochvil.net/priv/captive/${P}cvs.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 -*"

IUSE="debug"

RDEPEND="sys-libs/readline
	>=gnome-base/orbit-2.8.2
	gnome-base/gnome-vfs
	dev-libs/popt
	dev-libs/glib
	>=dev-libs/openssl-0.9.7c
	>=dev-libs/libxml2-2.4.29
	>=sys-fs/fuse-2.2"

DEPEND="${RDEPEND}
	sys-fs/ntfsprogs"

S=${WORKDIR}/${P}cvs

pkg_setup() {
	einfo "Adding captive user and group"
	enewgroup captive || die "enewgroup captive failed"
	enewuser captive -1 -1 /dev/null captive || die "enewuser captive failed"
}

src_compile() {
	# disable some tests to save time ;)
	econf `use_enable debug bug-replay` \
		--disable-static \
		--with-readline \
		--disable-lufs \
		--enable-fuse \
		--enable-sandbox-setuid=captive \
		--enable-sandbox-setgid=captive \
		--enable-sandbox-chroot=/var/lib/captive \
		--enable-man-pages \
		--enable-sbin-mountdir=/sbin \
		--enable-sbin-mount-fs=ntfs:fastfat:cdfs:ext2fsd \
		--disable-gtk-doc \
		--with-orbit-line=link \
		--disable-glibtest --disable-orbittest \
		--with-tmpdir=/tmp --localstatedir=/var || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	dodir   /var/lib/captive
	diropts -m1777
	dodir   /var/lib/captive/tmp
	keepdir /var/lib/captive/tmp

	rm -R	${D}/etc/rc.d

	dodoc AUTHORS ChangeLog README TODO
}

pkg_postinst() {
	einfo "Use /usr/sbin/captive-install-acquire to search for and"
	einfo "install the needed drivers for captive NTFS."
	einfo ""
	einfo "Please use \"mount -t captive-ntfs /dev/hda1 /mnt/ntfs\" to mount ntfs partitions."
}

pkg_postrm() {
	#einfo Removing captive user
	#userdel captive
	#einfo Removing captive group
	#groupdel captive
	einfo ""
	einfo "You will have to remove captive user and group manually"
	einfo ""
}
