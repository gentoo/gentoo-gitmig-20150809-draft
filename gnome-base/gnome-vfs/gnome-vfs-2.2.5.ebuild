# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-vfs/gnome-vfs-2.2.5.ebuild,v 1.1 2003/05/22 12:36:33 foser Exp $

IUSE="doc ssl"

inherit gnome2 eutils

DESCRIPTION="Gnome Virtual Filesystem"
HOMEPAGE="http://www.gnome.org/"
SLOT="2"
KEYWORDS="~x86 ~ppc ~alpha ~sparc"
LICENSE="GPL-2 LGPL-2.1"

RDEPEND=">=dev-libs/glib-2
	>=gnome-base/gconf-1.2.1
	>=gnome-base/ORBit2-2.4
	>=gnome-base/libbonobo-2
	>=gnome-base/bonobo-activation-1
	>=dev-libs/libxml2-2.2.8
	>=gnome-base/gnome-mime-data-2
	app-admin/fam-oss	
	ssl? ( >=dev-libs/openssl-0.9.5 )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	doc? ( >=dev-util/gtk-doc-1 )"

DOCS="AUTHORS COPYING* ChangeLog HACKING INSTALL NEWS README TODO"
                                                                                
use ssl \
	&& G2CONF="${G2CONF} --enable-openssl" \
	|| G2CONF="${G2CONF} --disable-openssl"

src_install() {
	gnome2_src_install

	# FIXME: there are bettere ways
	echo "trash:    libvfolder-desktop.so">>${D}/etc/gnome-vfs-2.0/modules/default-modules.conf
}

pkg_preinst () {
	## this check is there because gnome-vfs still adheres the file, though it doesn't need it. backwards compliance isnt always good
	REMOVE="${ROOT}/etc/gnome-vfs-2.0/vfolders/applications.vfolder-info"
	if [ -f ${REMOVE} ] ; then
		rm -f ${REMOVE}
	fi
}
