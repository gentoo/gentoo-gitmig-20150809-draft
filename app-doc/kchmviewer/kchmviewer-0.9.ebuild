# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/kchmviewer/kchmviewer-0.9.ebuild,v 1.3 2005/06/12 15:51:24 greg_g Exp $

inherit kde-functions eutils

DESCRIPTION="Qt-based feature rich CHM file viewer."
HOMEPAGE="http://kchmviewer.sourceforge.net/"
SRC_URI="mirror://sourceforge/kchmviewer/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"
IUSE="arts kde"

RDEPEND="kde? ( kde-base/kdelibs )"

DEPEND="${RDEPEND}
	sys-devel/autoconf
	sys-devel/automake"

need-kde 3.3

pkg_setup() {
	if use kde && use arts && ! built_with_use kdelibs arts ; then
		eerror "You are trying to compile ${CATEGORY}/${P} with the \"arts\" USE flag enabled."
		eerror "However, $(best_version kdelibs) was compiled with this flag disabled."
		eerror
		eerror "You must either disable this use flag, or recompile"
		eerror "$(best_version kdelibs) with this use flag enabled."
		die
	fi
}

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

src_compile() {
	set-kdedir 3

	econf $(use_with kde) $(use_with arts) || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc ChangeLog
}
