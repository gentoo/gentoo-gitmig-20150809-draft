# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/captive/captive-1.1.5-r1.ebuild,v 1.1 2004/12/05 22:01:49 genstef Exp $

inherit eutils

DESCRIPTION="Captive uses binary Windows drivers for full NTFS r/w access."
HOMEPAGE="http://www.jankratochvil.net/project/captive/"
SRC_URI="http://www.jankratochvil.net/project/captive/dist/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE="debug gtk static"

	# sys-fs/lufis-0.2(fuse) or sys-fs/lufs not needed for compiling,
	# but for luf(i)s mounting, gnomevfs works w/o it though..
RDEPEND="sys-libs/readline
	>=gnome-base/orbit-2.8.2
	gnome-base/gnome-vfs
	dev-libs/popt
	dev-libs/glib
	>=dev-libs/openssl-0.9.7c
	>=dev-libs/libxml2-2.4.29
	sys-fs/lufis
	gtk? (
		gnome-extra/gnome-vfs-httpcaptive
		gnome-base/libbonobo
		gnome-base/libgnomeui
		)"

DEPEND="${RDEPEND}
	sys-fs/ntfsprogs"

pkg_setup() {
	einfo "Adding captive user and group"
	enewgroup captive || die "enewgroup captive failed"
	enewuser captive -1 /bin/false /dev/null captive \
		|| die "enewuser captive failed"
}

src_unpack() {
	unpack ${A}

	# This is needed because that scripts will cause an sandbox violation
	# if Xvnc is installed and its not needed anyways
	# if it breaks, use the virtualx eclass and Xeconf
	cd ${S}
	epatch ${FILESDIR}/do-not-check-for-lufsd.patch
	epatch ${FILESDIR}/use-lufis-for-mount-t-captive.patch
	cp -f configure configure.orig
	grep -v 'sh ./macros/glade-w' configure.orig > configure
}

src_compile() {
	# disable some tests to save time ;)
	econf `use_enable debug bug-replay` \
		`use_enable static` \
		`use_enable gtk install-pkg` \
		--with-readline \
		--enable-lufs \
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

	dodoc AUTHORS COPYING* ChangeLog* NEWS README* TODO \
		|| die "dodoc failed"
}

pkg_postinst() {
	if use gtk; then
		einfo "Use /usr/sbin/captive-install-acquire to search for and"
		einfo "install the needed drivers for captive NTFS."
		einfo ""
	fi
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
