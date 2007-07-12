# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/qtparted/qtparted-0.4.5.ebuild,v 1.5 2007/07/12 05:10:21 mr_bones_ Exp $

inherit qt3 multilib autotools

DESCRIPTION="nice Qt partition tool for Linux"
HOMEPAGE="http://qtparted.sourceforge.net/"
SRC_URI="mirror://sourceforge/qtparted/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE="jfs ntfs reiserfs xfs gnome kde" # kdeenablefinal"

DEPEND="$(qt_min_version 3.1)
	>=sys-apps/parted-1.6.7
	>=sys-fs/e2fsprogs-1.33
	jfs? ( >=sys-fs/jfsutils-1.1.2 )
	ntfs? ( >=sys-fs/ntfsprogs-1.7.1 )
	reiserfs? ( sys-fs/progsreiserfs )
	xfs? ( >=sys-fs/xfsprogs-2.3.9 )"

RDEPEND="${DEPEND}
	kde? ( || ( kde-base/kdesu kde-base/kdebase ) )
	!kde? ( x11-libs/gksu )"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Fix up for parted v1.7
	epatch ${FILESDIR}/qtparted-0.4.5-parted-1.7-fix.patch

	# Switch from gksu to kdesu for the KDE desktop.
	if use kde; then
		use gnome || sed -i -e 's/gksu/kdesu/' debian/menu ||
			die "sed debian/menu failed"
		sed -i -e 's/Exec=/Exec=kdesu /' data/qtparted.desktop ||
			die "sed data/qtparted.desktop failed"
	fi

	# Distribution was rigged for unsermake - re-work for normal make,
	# and support autotools 2.6.  Also fix version identifier (this is
	# a full release, not just cvs).
	sed -i -e 's:0.4.5-cvs:0.4.5:' configure.ac ||
		die "sed configure.ac failed for version id"
	sed -i -e 's:KDE_AUTOCONF_VERS=\":KDE_AUTOCONF_VERS=\"-2.60 :
			s:KDE_AUTOMAKE_VERS=\":KDE_AUTOMAKE_VERS=\"-1.9 :' \
			admin/detect-autoconf.sh ||
		die "sed admin/detect-autoconf.sh for autoconf/automake failed"
	sed -i -e 's:autoconf\*2.5\*:autoconf\*2.5\* | autoconf\*2.6\*:
			s:autoheader\*2.5\*:autoheader\*2.5\* | autoheader\*2.6\*:' \
			admin/cvs.sh ||
		die "sed admin/cvs.sh for autoconf/autoheader failed"
	sh admin/cvs.sh dist
}

src_compile() {
	# No need to set --with-qt-dir as it'll be picked up from QTDIR (set by
	# qt3.eclass), similarly --with-qt-includes.  The library directory
	# needs to take account of multilib, however.
	econf \
		$(use_enable jfs) \
		$(use_enable ntfs) \
		$(use_enable reiserfs) \
		$(use_enable xfs) \
		--disable-final \
		--enable-labels \
		--with-qt-libraries=${QTDIR}/$(get_libdir) ||
		die "configure failed"
#		$(use_enable kdeenablefinal final) \
	emake || die "make failed"
}

src_install() {
	einstall || die "install failed"
	dodoc doc/README doc/README.Debian doc/TODO.txt doc/BUGS doc/DEVELOPER-FAQ
}
