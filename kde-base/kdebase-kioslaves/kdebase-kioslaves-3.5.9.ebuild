# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebase-kioslaves/kdebase-kioslaves-3.5.9.ebuild,v 1.4 2008/05/12 16:49:40 armin76 Exp $

KMNAME=kdebase
KMMODULE=kioslave
EAPI="1"
inherit kde-meta eutils

SRC_URI="${SRC_URI}
	mirror://gentoo/kdebase-3.5-patchset-11.tar.bz2"

DESCRIPTION="kioslave: the kde VFS framework - kioslave plugins present a filesystem-like view of arbitrary data"
KEYWORDS="alpha ~amd64 ~hppa ia64 ~ppc ~ppc64 sparc ~x86 ~x86-fbsd"
IUSE="hal kdehiddenvisibility ldap openexr samba"

DEPEND="ldap? ( net-nds/openldap )
	samba? ( >=net-fs/samba-3.0.1 )
	>=dev-libs/cyrus-sasl-2
	hal? ( dev-libs/dbus-qt3-old =sys-apps/hal-0.5* )
	openexr? ( >=media-libs/openexr-1.2.2-r2 )
	!<kde-base/kdesktop-3.5.6-r1"
RDEPEND="${DEPEND}
	virtual/ssh
	>=kde-base/kdialog-${PV}:${SLOT}"	# for the kdeeject script used by the devices/mounthelper ioslave
DEPEND="${DEPEND}
	x11-apps/xhost"

# see bug #143375
KMEXTRA="kdesktop/init"

pkg_setup() {
	kde_pkg_setup
	if use hal && has_version '<sys-apps/dbus-0.91' && ! built_with_use sys-apps/dbus qt3; then
		eerror "To enable HAL support in this package is required to have"
		eerror "sys-apps/dbus compiled with Qt 3 support."
		eerror "Please reemerge sys-apps/dbus with USE=\"qt3\"."
		die "Please reemerge sys-apps/dbus with USE=\"qt3\"."
	fi
}

src_unpack() {
	kde-meta_src_unpack
	#  FIXME - disable broken tests
	sed -i -e "s:TESTS =.*:TESTS =:" "${S}/kioslave/smtp/Makefile.am" || die "sed failed"
	sed -i -e "s:TESTS =.*:TESTS =:" "${S}/kioslave/trash/Makefile.am" || die "sed failed"

	if ! [[ $(xhost >> /dev/null 2>/dev/null) ]] ; then
		einfo "User ${USER} has no X access, disabling some tests."
		for ioslave in media remote home system ; do
			sed -e "s:check\: test${ioslave}::" -e "s:./test${ioslave}::" \
				-i kioslave/${ioslave}/Makefile.am || die "sed failed"
		done
	fi
}

src_compile() {
	myconf="$myconf $(use_with ldap) $(use_with samba) $(use_with hal) $(use_with openexr)"
	kde-meta_src_compile
}
