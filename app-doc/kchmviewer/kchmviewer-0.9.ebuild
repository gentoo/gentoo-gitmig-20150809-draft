# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/kchmviewer/kchmviewer-0.9.ebuild,v 1.2 2005/06/11 13:32:45 centic Exp $

inherit kde eutils

DESCRIPTION="Qt-based feature rich CHM file viewer."
HOMEPAGE="http://kchmviewer.sourceforge.net/"
SRC_URI="mirror://sourceforge/kchmviewer/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"
IUSE="kde"

RDEPEND="kde? ( kde-base/kdelibs )"

DEPEND="${RDEPEND}
	sys-devel/autoconf
	sys-devel/automake"

need-kde 3.3

src_unpack() {
	unpack ${A}
	cd ${S}

	# Fix PIC issue. Submitted upstream.
	epatch "${FILESDIR}/${P}-pic.patch"

	# Regenerate configure for the pic patch.
	einfo "Running autoreconf..."
	autoreconf || die
	perl am_edit || die
}

#src_compile() {
#	set-kdedir 3
#
#	econf $(use_with kde) || die
#	emake || die
#}

#src_install() {
#	make DESTDIR="${D}" install || die
#	dodoc ChangeLog
#}
