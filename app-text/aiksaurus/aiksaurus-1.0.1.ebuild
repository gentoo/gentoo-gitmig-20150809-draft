# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/aiksaurus/aiksaurus-1.0.1.ebuild,v 1.7 2004/07/13 20:42:31 agriffis Exp $

inherit flag-o-matic eutils

DESCRIPTION="A thesaurus lib, tool and database"
HOMEPAGE="http://sourceforge.net/projects/aiksaurus"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
IUSE=""

DEPEND="sys-devel/gcc"

src_unpack() {
	unpack ${A}

	# fix -DGTK_DEPRECATED
	cd ${S}
	mv configure configure.old
	sed 's/-DGTK_DISABLE_DEPRECATED//g'  configure.old > configure

	# configure needs +x bit
	chmod +x configure

	cd ${S}/base
	epatch ${FILESDIR}/${PN}-0.15-gentoo.patch || die
}

src_compile() {
	filter-flags -fno-exceptions

	econf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS README* ChangeLog
}
