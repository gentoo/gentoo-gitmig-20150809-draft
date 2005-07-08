# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebase-kioslaves/kdebase-kioslaves-3.4.1-r1.ebuild,v 1.5 2005/07/08 03:08:04 weeve Exp $

KMNAME=kdebase
KMMODULE=kioslave
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="kioslave: the kde VFS framework - kioslave plugins present a filesystem-like view of arbitrary data"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE="hal ldap samba"
DEPEND="ldap? ( net-nds/openldap )
	samba? ( >=net-fs/samba-3.0.1 )
	>=dev-libs/cyrus-sasl-2
	hal? ( =sys-apps/dbus-0.23*
	       =sys-apps/hal-0.4* )"
RDEPEND="${DEPEND}
	$(deprange $PV $MAXKDEVER kde-base/kdialog)"  # for the kdeeject script used by the devices/mounthelper ioslave

PATCHES="${FILESDIR}/kdebase-3.4.1-configure.patch"

src_compile () {
	myconf="$myconf `use_with ldap` `use_with samba` `use_with hal`"
	kde-meta_src_compile
}

