# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/gentoolkit-dev/gentoolkit-dev-0.2.3.ebuild,v 1.4 2005/04/03 04:06:59 josejx Exp $

DESCRIPTION="Collection of developer scripts for Gentoo"
HOMEPAGE="http://www.gentoo.org/~karltk/projects/gentoolkit/"
#SRC_URI="http://dev.gentoo.org/~karltk/projects/gentoolkit/releases/${P}.tar.gz"
SRC_URI="http://dev.gentoo.org/~karltk/projects/gentoolkit/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
#KEYWORDS="~x86 ~ppc ~sparc ~mips ~alpha ~arm ~hppa ~amd64 ~ia64 ~ppc64 ~s390 ~ppc-macos"
KEYWORDS="x86 ppc sparc ~mips alpha ~arm ~hppa amd64 ia64 ~ppc64 ~s390 ~ppc-macos"
IUSE=""

DEPEND=">=sys-apps/portage-2.0.50
	>=dev-lang/python-2.0
	>=dev-util/dialog-0.7
	>=dev-lang/perl-5.6
	>=sys-apps/grep-2.4"

src_install() {
	make DESTDIR=${D} install-gentoolkit-dev
}
