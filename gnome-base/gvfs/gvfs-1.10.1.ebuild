# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gvfs/gvfs-1.10.1.ebuild,v 1.2 2011/10/17 16:46:51 ssuominen Exp $

EAPI=4
GCONF_DEBUG=no
GNOME2_LA_PUNT=yes

inherit autotools bash-completion-r1 eutils gnome2

[[ ${PV} = 9999 ]] && inherit gnome2-live

DESCRIPTION="GNOME Virtual Filesystem Layer"
HOMEPAGE="http://www.gnome.org"

LICENSE="LGPL-2"
SLOT="0"

if [[ ${PV} = 9999 ]]; then
	KEYWORDS=""
	DOCS=""
else
	KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
	DOCS="AUTHORS ChangeLog NEWS MAINTAINERS README TODO" # ChangeLog.pre-1.2 README.commits
fi

IUSE="archive avahi bluetooth bluray cdda crypt doc fuse gdu gnome-keyring gphoto2 +http ios prefix samba +udev"

RDEPEND=">=dev-libs/glib-2.29.14
	sys-apps/dbus
	dev-libs/libxml2
	net-misc/openssh
	!prefix? ( >=sys-fs/udev-164-r2 )
	archive? ( app-arch/libarchive )
	avahi? ( >=net-dns/avahi-0.6 )
	bluetooth? (
		>=app-mobilephone/obex-data-server-0.4.5
		dev-libs/dbus-glib
		net-wireless/bluez
		dev-libs/expat )
	bluray? ( media-libs/libbluray )
	crypt? ( dev-libs/libgcrypt )
	fuse? ( >=sys-fs/fuse-2.8.0 )
	gdu? ( >=sys-apps/gnome-disk-utility-3.0.2 )
	gnome-keyring? ( >=gnome-base/gnome-keyring-1.0 )
	gphoto2? ( >=media-libs/libgphoto2-2.4.7 )
	ios? (
		>=app-pda/libimobiledevice-1.1.0
		>=app-pda/libplist-1 )
	udev? (
		cdda? ( >=dev-libs/libcdio-0.78.2[-minimal] )
		|| ( >=sys-fs/udev-171[gudev] >=sys-fs/udev-145[extras] ) )
	http? ( >=net-libs/libsoup-gnome-2.26.0 )
	samba? ( >=net-fs/samba-3.4.6[smbclient] )"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.40
	dev-util/pkgconfig
	dev-util/gtk-doc-am
	doc? ( >=dev-util/gtk-doc-1 )"

REQUIRED_USE="cdda? ( udev )"

pkg_setup() {
	G2CONF="${G2CONF}
		--disable-bash-completion
		--disable-hal
		--disable-schemas-compile
		--with-dbus-service-dir=/usr/share/dbus-1/services
		$(use_enable archive)
		$(use_enable avahi)
		$(use_enable bluetooth obexftp)
		$(use_enable bluray)
		$(use_enable cdda)
		$(use_enable crypt afp)
		$(use_enable fuse)
		$(use_enable gdu)
		$(use_enable gphoto2)
		$(use_enable ios afc)
		$(use_enable udev gudev)
		$(use_enable http)
		$(use_enable gnome-keyring keyring)
		$(use_enable samba)
		$(use_enable !prefix udev)"
}

src_prepare() {
	gnome2_src_prepare

	# Conditional patching purely to avoid eautoreconf
	use gphoto2 && epatch "${FILESDIR}"/${PN}-1.2.2-gphoto2-stricter-checks.patch

	if use archive; then
		epatch "${FILESDIR}"/${PN}-1.2.2-expose-archive-backend.patch
		echo mount-archive.desktop.in >> po/POTFILES.in
		echo mount-archive.desktop.in.in >> po/POTFILES.in
	fi

	if use prefix; then
		sed -i -e 's/gvfsd-burn/ /' daemon/Makefile.am || die
		sed -i -e 's/burn.mount.in/ /' daemon/Makefile.am || die
		sed -i -e 's/burn.mount/ /' daemon/Makefile.am || die
	fi

	{ use gphoto2 || use archive || use prefix; } && eautoreconf
}

src_install() {
	gnome2_src_install
	newbashcomp programs/gvfs-bash-completion.sh ${PN}
}
