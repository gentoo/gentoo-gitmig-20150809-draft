# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/ac-archive/ac-archive-2006.1017.ebuild,v 1.2 2008/01/17 13:58:49 maekke Exp $

inherit autotools

DESCRIPTION="The Autoconf Macro Archive"
HOMEPAGE="http://ac-archive.sourceforge.net/"
SRC_URI="mirror://sourceforge/ac-archive/${P}.tar.bz2"

LICENSE="|| ( BSD GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="app-text/aspell"
RDEPEND="dev-lang/perl"

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc README TODO ChangeLog
	mv "${D}"/usr/share/doc/${PN} "${D}"/usr/share/doc/${PF}/html || die
}
