# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebase-kioslaves/kdebase-kioslaves-3.4.0_beta1.ebuild,v 1.2 2005/01/18 22:21:17 motaboy Exp $

KMNAME=kdebase
KMMODULE=kioslave
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="kioslave: the kde VFS framework - kioslave plugins present a filesystem-like view of arbitrary data"
KEYWORDS="~x86"
IUSE="ldap samba"
DEPEND="ldap? ( net-nds/openldap )
		samba? ( >=net-fs/samba-3.0.1 )
		>=dev-libs/cyrus-sasl-2
		$(deprange-dual $PV $MAXKDEVER kde-base/kdesktop)" # for the kdeeject script used by the devices/mounthelper ioslave


src_compile () {
	myconf="$myconf `use_with ldap`"
	kde-meta_src_compile
}

