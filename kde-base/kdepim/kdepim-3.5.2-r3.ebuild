# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepim/kdepim-3.5.2-r3.ebuild,v 1.3 2006/05/30 04:16:05 josejx Exp $

inherit kde-dist

DESCRIPTION="KDE PIM (Personal Information Management) apps: korganizer, kmail, knode..."

SRC_URI="${SRC_URI}
	mirror://gentoo/kdepim-3.5.2-patchset.tar.bz2"

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ppc ~ppc64 ~sparc ~x86"
IUSE="crypt gnokii pda"

DEPEND="~kde-base/kdebase-${PV}
	>=dev-libs/cyrus-sasl-2
	pda? ( app-pda/pilot-link dev-libs/libmal )
	gnokii? ( app-mobilephone/gnokii )
	crypt? ( >=app-crypt/gpgme-1.1.2-r1
		 <app-crypt/gnupg-1.9 )"
	# We use GnuPG 1.4.x for OpenPGP and 1.9 (via gpgme) for s/mime as upstream advises.
RDEPEND="${DEPEND}
	crypt? ( !hppa? ( ( app-crypt/pinentry ) ) )"

PATCHES="${WORKDIR}/kdepim-3.5.2-patchset.diff"

src_compile() {
	local myconf="--with-sasl $(use_with gnokii) --enable-indexlib"
	use crypt && myconf="${myconf} --with-gpg=${ROOT}/usr/bin/gpg"

	kde_src_compile
}
