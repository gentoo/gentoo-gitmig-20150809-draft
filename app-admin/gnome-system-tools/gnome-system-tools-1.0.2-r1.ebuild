# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/gnome-system-tools/gnome-system-tools-1.0.2-r1.ebuild,v 1.10 2005/04/02 04:06:47 geoman Exp $

inherit gnome2 eutils

DESCRIPTION="Tools aimed to make easy the administration of UNIX systems"
HOMEPAGE="http://www.gnome.org/projects/gst/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc sparc x86"
IUSE=""

RDEPEND="net-misc/openssh
	sys-apps/shadow
	>=x11-libs/gtk+-2.4
	>=gnome-base/libgnomeui-1.109
	>=gnome-base/libglade-1.99.5
	>=gnome-base/gconf-2.2
	>=dev-libs/libxml2-2.4.12"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.29"

DOCS="AUTHORS BUGS ChangeLog HACKING NEWS README TODO"

USE_DESTDIR="1"

# --enable-disks is not supported for Gentoo at the moment.
G2CONF="${G2CONF} --enable-boot --enable-services"

src_unpack() {

	unpack ${A}
	# Patch to fix space mangling in ntp.conf, this
	# has been fixed in g-s-t CVS, so we don't need
	# it after this revision. bug #71235.
	# <obz@gentoo.org>
	epatch ${FILESDIR}/${P}-ntp.patch

}
