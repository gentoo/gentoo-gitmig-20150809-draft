# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebase-kioslaves/kdebase-kioslaves-3.4.0.ebuild,v 1.2 2005/03/18 18:03:03 morfic Exp $

KMNAME=kdebase
KMMODULE=kioslave
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="kioslave: the kde VFS framework - kioslave plugins present a filesystem-like view of arbitrary data"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE="hal ldap samba"
DEPEND="ldap? ( net-nds/openldap )
	samba? ( >=net-fs/samba-3.0.1 )
	>=dev-libs/cyrus-sasl-2
	hal? ( >=sys-apps/dbus-0.22-r3
	       >=sys-apps/hal-0.4 )
	$(deprange $PV $MAXKDEVER kde-base/kdesktop)" # for the kdeeject script used by the devices/mounthelper ioslave


src_compile () {
	myconf="$myconf `use_with ldap` `use_with hal`"
	kde-meta_src_compile
}

