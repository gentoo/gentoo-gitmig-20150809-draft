# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/captive/captive-1.1.7-r1.ebuild,v 1.3 2006/04/05 12:46:06 genstef Exp $

inherit eutils

DESCRIPTION="Captive uses binary Windows drivers for full NTFS r/w access."
HOMEPAGE="http://www.jankratochvil.net/project/captive/"
SRC_URI="http://www.jankratochvil.net/project/captive/dist/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 -*"

IUSE="debug gtk readline"

RDEPEND="sys-libs/zlib
	>=sys-fs/fuse-2.4
	readline? ( sys-libs/readline )
	>=dev-libs/openssl-0.9.7c
	>=dev-libs/libxml2-2.4.29
	>=gnome-base/orbit-2.8.2
	gnome-base/gconf
	gnome-base/libbonobo
	gnome-base/gnome-vfs
	dev-libs/popt
	dev-libs/glib
	gtk? (
		dev-libs/atk
		sys-fs/ntfsprogs
		gnome-base/libbonoboui
		gnome-base/libgnomeui
		media-libs/libpng
		>x11-libs/gtk+-2.2
		x11-libs/pango
	)"

DEPEND="${RDEPEND}"

pkg_setup() {
	einfo "Adding captive user and group"
	enewgroup captive || die "enewgroup captive failed"
	enewuser captive -1 -1 /dev/null captive || die "enewuser captive failed"
}

src_compile() {
	# disable some tests to save time ;)
	econf $(use_enable debug bug-replay) \
		$(use_with readline) \
		$(use_enable gtk install-pkg) \
		--enable-fuse \
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
	ewarn "captive-install-acquire is only provided with USE=gtk"
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
