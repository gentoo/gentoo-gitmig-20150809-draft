# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/magicdev/magicdev-1.1.4.ebuild,v 1.5 2004/06/14 09:05:19 kloeri Exp $

inherit gnome2 eutils

RPM_V="7"
DESCRIPTION="A GNOME tool to automount/unmount removable media"
HOMEPAGE="http://www.gnome.org/"
SRC_URI="ftp://ftp.redhat.com/pub/redhat/linux/beta/severn/en/os/i386/SRPMS/${P}-${RPM_V}.src.rpm"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND=">=gnome-base/libgnomeui-2.1.90
	>=gnome-base/libglade-2
	>=x11-libs/gtk+-2
	>=gnome-base/gconf-2"
DEPEND="${RDEPEND}
	app-arch/rpm2targz"

DOCS="AUTHORS ChangeLog README"

src_unpack() {
	rpm2targz ${DISTDIR}/${P}-${RPM_V}.src.rpm
	unpack ${P}-${RPM_V}.src.tar.gz
	unpack ${P}.tar.gz

	epatch magicdev-1.1.4-O_EXCL.patch
	epatch magicdev-1.1.4-blacklist.patch
}
