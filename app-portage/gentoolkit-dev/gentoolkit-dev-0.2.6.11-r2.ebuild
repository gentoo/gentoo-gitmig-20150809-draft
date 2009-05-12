# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/gentoolkit-dev/gentoolkit-dev-0.2.6.11-r2.ebuild,v 1.1 2009/05/12 18:57:11 idl0r Exp $

EAPI="2"

inherit eutils

DESCRIPTION="Collection of developer scripts for Gentoo"
HOMEPAGE="http://www.gentoo.org/proj/en/portage/tools/index.xml"
SRC_URI="mirror://gentoo/${P}.tar.gz http://dev.gentoo.org/~fuzzyray/distfiles/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd"
IUSE=""

DEPEND="sys-apps/portage
	dev-lang/perl"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/echangelog.patch"
}

src_install() {
	emake DESTDIR="${D}" install-gentoolkit-dev || die
}
