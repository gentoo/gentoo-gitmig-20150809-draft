# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepim/kdepim-3.4.2-r1.ebuild,v 1.1 2005/08/02 11:29:08 greg_g Exp $

inherit kde-dist eutils

DESCRIPTION="KDE PIM (Personal Information Management) apps: korganizer, kmail, knode..."

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86"
IUSE="crypt gnokii pda"

DEPEND="~kde-base/kdebase-${PV}
	>=dev-libs/cyrus-sasl-2
	pda? ( app-pda/pilot-link dev-libs/libmal )
	gnokii? ( app-mobilephone/gnokii )
	crypt? ( >=app-crypt/gpgme-0.9.0-r1 )"

src_unpack() {
	kde_src_unpack

	# Fix compilation with gcc 3.2 (kde bug 106274). Applied for 3.4.3.
	epatch "${FILESDIR}/kdepim-3.4.2-gcc32.patch"

	# Fix problem with attachments (kde bug 109003). Applied for 3.4.3.
	epatch "${FILESDIR}/kdepim-3.4.2-partnode.patch"

	# Configure patch. Applied for 3.5.
	epatch "${FILESDIR}/kdepim-3.4-configure.patch"

	# For the configure patch.
	make -f admin/Makefile.common
}

src_compile() {
	local myconf="--with-sasl $(use_with gnokii)"

	kde_src_compile
}
