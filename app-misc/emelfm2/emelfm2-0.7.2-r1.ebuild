# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/emelfm2/emelfm2-0.7.2-r1.ebuild,v 1.8 2010/07/14 13:21:20 fauli Exp $

EAPI=2
inherit eutils multilib toolchain-funcs

DESCRIPTION="A file manager that implements the popular two-pane design"
HOMEPAGE="http://emelfm2.net/"
SRC_URI="http://${PN}.net/rel/${P}.tar.bz2"

LICENSE="GPL-3 LGPL-3"
SLOT="0"
KEYWORDS="amd64 ~ppc ~ppc64 ~sparc x86"
IUSE="acl fam gimp kernel_linux nls policykit spell udev"

RDEPEND=">=x11-libs/gtk+-2.12:2
	acl? ( sys-apps/acl )
	!kernel_linux? ( fam? ( virtual/fam ) )
	gimp? ( media-gfx/gimp )
	policykit? ( sys-auth/polkit )
	spell? ( app-text/gtkspell )
	udev? ( || ( sys-fs/udisks sys-apps/devicekit-disks )
		dev-libs/dbus-glib )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

RESTRICT="test"

pkg_setup() {
	myconf="DOCS_VERSION=1 WITH_TRANSPARENCY=1 STRIP=0"

	use udev && myconf="${myconf} WITH_DEVKIT=1"
	use gimp && myconf="${myconf} WITH_THUMBS=1"
	use acl && myconf="${myconf} WITH_ACL=1"
	use kernel_linux && myconf="${myconf} WITH_KERNELFAM=1 USE_INOTIFY=1"
	use spell && myconf="${myconf} EDITOR_SPELLCHECK=1"
	use nls || myconf="${myconf} I18N=0"
	use policykit && myconf="${myconf} WITH_POLKIT=1"

	if ! use kernel_linux && use fam; then
		if has_version "app-admin/gamin"; then
			myconf="${myconf} USE_GAMIN=1"
		else
			myconf="${myconf} USE_FAM=1"
		fi
	fi
}

src_compile() {
	tc-export CC
	emake LIB_DIR="/usr/$(get_libdir)" PREFIX="/usr" \
		${myconf} || die
}

src_install() {
	emake LIB_DIR="${D}/usr/$(get_libdir)" PREFIX="${D}/usr" \
		${myconf} install || die
	newicon icons/${PN}_48.png ${PN}.png
	prepalldocs
}
