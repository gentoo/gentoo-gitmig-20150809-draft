# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/file-roller/file-roller-2.12.3.ebuild,v 1.9 2006/04/21 20:37:44 tcort Exp $

inherit eutils gnome2

DESCRIPTION="archive manager for GNOME"
HOMEPAGE="http://fileroller.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2.6
	>=x11-libs/gtk+-2.6
	>=gnome-base/libgnome-2.6
	>=gnome-base/libgnomeui-2.6
	>=gnome-base/gnome-vfs-2.9
	>=gnome-base/libglade-2.4
	>=gnome-base/libbonobo-2.6
	>=gnome-base/libbonoboui-2.6
	>=gnome-base/nautilus-2.9
	>=gnome-base/gconf-2
	>=app-text/gnome-doc-utils-0.3.2
	"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	>=app-text/scrollkeeper-0.3.11"

DOCS="AUTHORS ChangeLog HACKING MAINTAINERS NEWS README TODO"
USE_DESTDIR="1"

pkg_setup() {
	G2CONF="${G2CONF} --disable-scrollkeeper"
}

src_unpack() {

	unpack ${A}
	cd ${S}

	# Use absolute path to GNU tar since star doesn't have the same
	# options.  On Gentoo, star is /usr/bin/tar, GNU tar is /bin/tar
	epatch ${FILESDIR}/${PN}-2.10.3-use_bin_tar.patch
	# use a local rpm2cpio script to avoid the dep
	epatch ${FILESDIR}/${PN}-2.10-use_fr_rpm2cpio.patch
}

src_install() {

	gnome2_src_install
	dobin ${FILESDIR}/rpm2cpio-file-roller

}
