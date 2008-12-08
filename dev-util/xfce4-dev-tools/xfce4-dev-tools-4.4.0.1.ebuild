# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/xfce4-dev-tools/xfce4-dev-tools-4.4.0.1.ebuild,v 1.4 2008/12/08 21:33:41 ranger Exp $

DESCRIPTION="m4macros for autotools eclass and subversion builds"
HOMEPAGE="http://foo-projects.org/~benny/projects/xfce4-dev-tools"
SRC_URI="mirror://xfce/xfce-4.4.2/src/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~mips ppc ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog HACKING NEWS README
}
