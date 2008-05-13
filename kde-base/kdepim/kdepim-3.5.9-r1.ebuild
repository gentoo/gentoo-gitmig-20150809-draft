# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepim/kdepim-3.5.9-r1.ebuild,v 1.6 2008/05/13 15:30:22 jer Exp $

EAPI="1"
inherit kde-dist

SRC_URI="${SRC_URI}
	mirror://gentoo/kdepim-3.5-patchset-04.tar.bz2"

DESCRIPTION="KDE PIM (Personal Information Management) applications: KOrganizer, KMail, KNode,..."

KEYWORDS="alpha ~amd64 hppa ia64 ~mips ppc ppc64 sparc ~x86"
IUSE="pda gnokii"

# Even more tests are broken now than before...
RESTRICT="test"

# We use GnuPG 1.4.x for OpenPGP and 1.9 (via gpgme) for s/mime as upstream advises.
DEPEND="~kde-base/kdebase-${PV}
		>=dev-libs/cyrus-sasl-2
		gnokii? ( app-mobilephone/gnokii )
		>=app-crypt/gpgme-1.1.2-r1
		|| ( >=app-crypt/gnupg-2.0.1-r1 <app-crypt/gnupg-1.9 )
		x11-libs/libXScrnSaver
		app-pda/libopensync
		pda? ( >=app-pda/pilot-link-0.12.0 >=dev-libs/libmal-0.44 )"

RDEPEND="${DEPEND}
		app-crypt/pinentry"

DEPEND="${DEPEND}
	x11-proto/scrnsaverproto
	x11-apps/xhost"

PATCHES=( "${FILESDIR}/certmanager-${PV}-fix-kdeenablefinal.patch"
			"${FILESDIR}/korganizer-${PV}-kdeenablefinal.patch"
			"${FILESDIR}/akregator-${PV}-customcolors.patch" )

src_unpack() {
	kde_src_unpack

	# Call Qt 3 designer
	sed -i -e "s:\"designer\":\"${QTDIR}/bin/designer\":g" "${S}"/libkdepim/kcmdesignerfields.cpp || die "sed failed"
}

src_compile() {
	local myconf="--with-sasl $(use_with gnokii)"
	myconf="${myconf} --with-gpg=/usr/bin/gpg"

	use pda || DO_NOT_COMPILE="${DO_NOT_COMPILE} kpilot"

	kde_src_compile
}

pkg_postinst() {
	kde_pkg_postinst

	ewarn "If you're using x11-misc/basket, please re-emerge it now to avoid crashes with Kontact."
	ewarn "cf. https://bugs.gentoo.org/show_bug.cgi?id=174872 for details."
}
