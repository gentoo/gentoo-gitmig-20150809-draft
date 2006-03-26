# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebase-kioslaves/kdebase-kioslaves-3.4.3.ebuild,v 1.8 2006/03/26 19:13:39 agriffis Exp $

KMNAME=kdebase
KMMODULE=kioslave
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

SRC_URI="${SRC_URI} mirror://gentoo/kdebase-3.4.3-kubuntu-hal.patch.gz"

DESCRIPTION="kioslave: the kde VFS framework - kioslave plugins present a filesystem-like view of arbitrary data"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE="hal ldap samba openexr"
DEPEND="ldap? ( net-nds/openldap )
	samba? ( >=net-fs/samba-3.0.1 )
	>=dev-libs/cyrus-sasl-2
	hal? ( sys-apps/dbus
	       sys-apps/hal )
	openexr? ( media-libs/openexr )"
RDEPEND="${DEPEND}
	$(deprange 3.4.1 $MAXKDEVER kde-base/kdialog)"  # for the kdeeject script used by the devices/mounthelper ioslave

# for --with-samba
PATCHES="${FILESDIR}/kdebase-3.4.1-configure.patch"
# for --with-openexr
PATCHES="$PATCHES $FILESDIR/configure-fix-kdebase-openexr.patch"
# Use the kubuntu patch to allow the kioslave to work with the new hal/dbus
PATCHES="${PATCHES} ${DISTDIR}/kdebase-3.4.3-kubuntu-hal.patch.gz"

myconf="$myconf `use_with ldap` `use_with samba` `use_with hal` `use_with openexr`"

