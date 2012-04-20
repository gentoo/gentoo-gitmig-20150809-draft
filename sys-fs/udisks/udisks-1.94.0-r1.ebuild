# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/udisks/udisks-1.94.0-r1.ebuild,v 1.3 2012/04/20 18:48:07 ssuominen Exp $

EAPI=4
inherit eutils bash-completion-r1 linux-info systemd

DESCRIPTION="Daemon providing interfaces to work with storage devices"
HOMEPAGE="http://www.freedesktop.org/wiki/Software/udisks"
SRC_URI="http://udisks.freedesktop.org/releases/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="debug doc crypt +introspection"

# WARNING: sys-apps/acl goes to COMMON_DEPEND in next version!
COMMON_DEPEND=">=dev-libs/glib-2.32
	>=sys-auth/polkit-0.104-r1
	>=dev-libs/libatasmart-0.18
	|| ( >=sys-fs/udev-171-r5[gudev] <sys-fs/udev-171[extras] )
	introspection? ( >=dev-libs/gobject-introspection-1.30 )"
# acl -> src/udiskslinuxfilesystem.c -> setfacl #412377
# gptfdisk -> src/udiskslinuxpartition.c -> sgdisk
# util-linux -> mount, umount, swapon, swapoff
RDEPEND="${COMMON_DEPEND}
	sys-apps/acl
	>=sys-apps/gptfdisk-0.8
	>=sys-apps/util-linux-2.20.1-r2
	>=sys-block/parted-3
	virtual/eject
	crypt? ( sys-fs/cryptsetup )"
DEPEND="${COMMON_DEPEND}
	app-text/docbook-xsl-stylesheets
	dev-libs/libxslt
	dev-util/gdbus-codegen
	dev-util/intltool
	dev-util/pkgconfig
	doc? (
		dev-util/gtk-doc
		app-text/docbook-xml-dtd:4.1.2
		)"

DOCS="AUTHORS HACKING NEWS README"

pkg_setup() {
	# Listing only major arch's here to avoid tracking kernel's defconfig
	if use amd64 || use arm || use ppc || use ppc64 || use x86; then
		CONFIG_CHECK="~!IDE" #319829
		CONFIG_CHECK+=" ~TMPFS_POSIX_ACL" #412377
		CONFIG_CHECK+=" ~USB_SUSPEND" #331065
		linux-info_pkg_setup
	fi
}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-2.x-ntfs-3g.patch
}

src_configure() {
	econf \
		--localstatedir="${EPREFIX}"/var \
		--disable-static \
		$(use_enable debug) \
		$(use_enable doc gtk-doc) \
		$(use_enable introspection) \
		--with-html-dir="${EPREFIX}"/usr/share/doc/${PF}/html \
		"$(systemd_with_unitdir)"
}

src_install() {
	default

	local htmldir=udisks2
	if [[ -d ${ED}/usr/share/doc/${PF}/html/${htmldir} ]]; then
		dosym /usr/share/doc/${PF}/html/${htmldir} /usr/share/gtk-doc/html/${htmldir}
	fi

	rm -rf "${ED}"/etc/bash_completion.d
	dobashcomp tools/udisksctl-bash-completion.sh

	find "${ED}" -type f -name '*.la' -exec rm -f {} +

	keepdir /media
	keepdir /var/lib/udisks2 #383091
}
