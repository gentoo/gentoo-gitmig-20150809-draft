# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/gentoolkit/gentoolkit-0.2.0_pre8-r1.ebuild,v 1.1 2004/10/31 01:08:35 genone Exp $

inherit eutils

DESCRIPTION="Collection of administration scripts for Gentoo"
HOMEPAGE="http://www.gentoo.org/~karltk/projects/gentoolkit/"
SRC_URI="http://dev.gentoo.org/~genone/distfiles/${P}.tar.gz"
#SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha arm hppa amd64 ia64 ppc64 s390 ~ppc-macos"
IUSE=""
#KEYWORDS="~x86 ~ppc ~sparc ~mips ~alpha ~arm ~hppa ~amd64 ~ia64 ~ppc64 "

DEPEND=">=sys-apps/portage-2.0.50
	>=dev-lang/python-2.0
	>=dev-util/dialog-0.7
	>=dev-lang/perl-5.6
	>=sys-apps/grep-2.4
	sys-apps/debianutils"


src_install() {
	# patch taken from cvs
	pwd
	epatch ${FILESDIR}/qpkg-security-fix-68846.diff
	make DESTDIR=${D} install-gentoolkit || die
}

pkg_postinst() {
	echo
	einfo "This version of ${PN} has a script to test the upcoming"
	einfo "portage GLSA integration (aka 'emerge security'). If you"
	einfo "want to try it out run"
	einfo "    glsa-check --help"
	einfo "and read the output carefully."
	echo
}
