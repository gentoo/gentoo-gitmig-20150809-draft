# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-vfs-extras/gnome-vfs-extras-0.99.6.ebuild,v 1.3 2002/12/04 13:21:06 foser Exp $

inherit gnome2

IUSE=""
S=${WORKDIR}/${P}
DESCRIPTION="the Gnome Virtual Filesystem extra libraries"
HOMEPAGE="http://www.gnome.org/"

SLOT="1"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~sparc64"

RDEPEND=">=gnome-base/gnome-vfs-2"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.20
	>=dev-util/pkgconfig-0.12.0
	>=sys-devel/autoconf-2.52"

src_unpack() {
	unpack ${A} || die "unpack failed"

	cd ${S}/samba
#	echo 'AC_PREREQ(2.52)' | cat - configure.in > configure.in.hacked
#	mv configure.in.hacked configure.in || die
#	autoconf
	export WANT_AUTOCONF_2_5=1
	autoconf --force
}
	
#src_compile() {
#	cd ${S}/samba
#	elibtoolize ${ELTCONF}
#	cd ${S}
#	gnome2_src_configure
#	emake || die "compile failure"
#}
	
DOCS="AUTHORS COPYING ChangeLog INSTALL NEWS  README"
