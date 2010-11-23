# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/autoconf-archive/autoconf-archive-2010.10.26.ebuild,v 1.1 2010/11/23 01:04:25 vapier Exp $

EAPI="3"

DESCRIPTION="GNU Autoconf Macro Archive"
HOMEPAGE="http://www.gnu.org/software/autoconf-archive/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~ppc-aix ~ia64-hpux ~x86-interix ~amd64-linux ~x86-linux ~sparc-solaris ~x86-solaris"
IUSE=""

src_install() {
	emake DESTDIR="${D}" install || die
	rm -rf "${D}"/usr/share/${PN} || die
	dodoc AUTHORS ChangeLog NEWS README TODO || die
}
