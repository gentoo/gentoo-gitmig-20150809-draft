# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/gentoolkit-dev/gentoolkit-dev-0.2.6.2.ebuild,v 1.14 2009/05/05 03:49:48 fuzzyray Exp $

inherit eutils

DESCRIPTION="Collection of developer scripts for Gentoo"
HOMEPAGE="http://www.gentoo.org/proj/en/portage/tools/index.xml"
SRC_URI="mirror://gentoo/${P}.tar.gz http://dev.gentoo.org/~fuzzyray/distfiles/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE=""

DEPEND=">=sys-apps/portage-2.0.50
	>=dev-lang/python-2.0
	>=dev-util/dialog-0.7
	>=dev-lang/perl-5.6
	>=sys-apps/grep-2.4"
RDEPEND="${DEPEND}"

src_unpack() {
	# This is to patch a cosmetic error in gentoolkit-dev-0.2.6.2, Remove from
	# next version bump
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PF}-Makefile.patch
}

src_install() {
	emake DESTDIR="${D}" install-gentoolkit-dev || die
}

pkg_postinst() {
	ewarn "The gensync utility has been deprecated in favor of"
	ewarn "app-portage/layman. It is still available in"
	ewarn "${ROOT}usr/share/doc/${PF}/deprecated/ for use while"
	ewarn "you migrate to layman."
}
