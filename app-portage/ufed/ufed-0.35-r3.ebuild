# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/ufed/ufed-0.35-r3.ebuild,v 1.2 2005/01/01 15:55:52 eradicator Exp $

inherit eutils

PATCHBALL="ufed-patches-2004-12-09.tar.gz"

DESCRIPTION="Gentoo Linux USE flags editor"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2
		 mirror://gentoo/${PATCHBALL} http://dev.gentoo.org/~genone/distfiles/${PATCHBALL}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~mips ~alpha ~arm ~hppa ~amd64 ~ia64 ~ppc64"
IUSE=""

RDEPEND="dev-lang/perl
	>=dev-util/dialog-1.0.20040731
	dev-perl/TermReadKey
	sys-apps/grep"

src_unpack() {
	unpack ${A}
	cd ${S}
	EPATCH_SOURCE="${WORKDIR}/patches" EPATCH_SUFFIX="patch" EPATCH_FORCE="yes" epatch
}

src_install() {
	newsbin ufed.pl ufed || die
	doman ufed.8
	dodoc ChangeLog
}
