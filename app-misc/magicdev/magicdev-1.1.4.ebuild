# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/magicdev/magicdev-1.1.4.ebuild,v 1.1 2003/10/30 16:29:34 leonardop Exp $

inherit gnome2

RPM_V="4"
DESCRIPTION="A GNOME tool to automount/unmount removable media."
HOMEPAGE="http://www.gnome.org/"
SRC_URI="http://ftp.redhat.com/pub/redhat/linux/9/en/os/i386/SRPMS/${P}-${RPM_V}.src.rpm"
LICENSE="GPL-2"

DOCS="AUTHORS ChangeLog COPYING README"
SLOT="0"
IUSE=""
KEYWORDS="~x86"
RDEPEND=">=gnome-base/libgnomeui-2.1.90
	>=gnome-base/libglade-2
	>=x11-libs/gtk+-2
	>=gnome-base/gconf-2"

DEPEND="${RDEPEND}
	app-arch/rpm2targz"

src_unpack() {
	cd ${WORKDIR}
	rpm2targz ${DISTDIR}/${P}-${RPM_V}.src.rpm
	tar zxf ${P}-${RPM_V}.src.tar.gz
	tar zxf ${P}.tar.gz
}

