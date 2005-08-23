# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/xxdiff/xxdiff-3.0.2-r1.ebuild,v 1.5 2005/08/23 16:56:19 agriffis Exp $

inherit eutils kde-functions

DESCRIPTION="A graphical file and directories comparator and merge tool."
HOMEPAGE="http://xxdiff.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~alpha ~amd64 ia64 ~ppc sparc x86"
IUSE="kde"

DEPEND="=x11-libs/qt-3*
	kde? ( >=kde-base/kdelibs-3.1 )"

RDEPEND="${DEPEND}
	sys-apps/diffutils"

DEPEND="${DEPEND}
	=dev-util/tmake-1.8*"

set-qtdir 3
set-kdedir 3

src_unpack()
{
	unpack ${A}

	if use kde; then
		cd ${S}/src
		cp ${FILESDIR}/kdesupport.patch ${T}/
		sed -i -e "s:/usr/kde/3.1:${KDEDIR}:g" ${T}/kdesupport.patch
		epatch ${T}/kdesupport.patch
	fi
}

src_compile() {
	cd src
	tmake -o Makefile xxdiff.pro

	### borrowed from kde.eclass #
	#
	# fix the sandbox errors "can't writ to .kde or .qt" problems.
	# this is a fake homedir that is writeable under the sandbox, so that the build
	# process can do anything it wants with it.
	REALHOME="${HOME}"
	mkdir -p ${T}/fakehome/.kde
	mkdir -p ${T}/fakehome/.qt
	export HOME="${T}/fakehome"

	# things that should access the real homedir
	[ -d "${REALHOME}/.ccache" ] && ln -sf "${REALHOME}/.ccache" "${HOME}/"

	emake || die
}

src_install () {
	dobin bin/xxdiff bin/xxdiff-cvs-diff bin/xxdiff-encrypted bin/xxdiff-find-grep-sed bin/xxdiff-match
	doman src/xxdiff.1
	dodoc README CHANGES TODO
}
