# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepim/kdepim-3.5.2-r2.ebuild,v 1.12 2006/10/17 09:43:25 flameeyes Exp $

inherit kde-dist

DESCRIPTION="KDE PIM (Personal Information Management) apps: korganizer, kmail, knode..."

KEYWORDS="alpha amd64 hppa ia64 mips ~ppc ppc64 sparc x86"
IUSE="crypt gnokii pda"

RDEPEND="~kde-base/kdebase-${PV}
	>=dev-libs/cyrus-sasl-2
	pda? ( app-pda/pilot-link dev-libs/libmal )
	gnokii? ( app-mobilephone/gnokii )
	crypt? ( >=app-crypt/gpgme-0.9.0-r1 )
	x11-libs/libXScrnSaver"

DEPEND="${DEPEND}
	x11-proto/scrnsaverproto"

PATCHES="${FILESDIR}/imap-dos.diff
	${FILESDIR}/libkcal-3.5.2-fixes.diff
	${FILESDIR}/kmail-3.5.2-imap-fixes-2.diff
	${FILESDIR}/kmail-3.5.2-misc-fixes-2.diff
	${FILESDIR}/libkdepim-3.5.2-call_qt3_designer.diff
	${FILESDIR}/libkdepim-3.5.2-fixes.diff
	${FILESDIR}/akregator-3.5-hppa.patch"

src_compile() {
	local myconf="--with-sasl $(use_with gnokii)"

	kde_src_compile
}
