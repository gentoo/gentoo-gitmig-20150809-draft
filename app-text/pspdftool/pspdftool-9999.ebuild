# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/pspdftool/pspdftool-9999.ebuild,v 1.1 2011/06/19 20:09:40 miska Exp $

EAPI=4

ESVN_REPO_URI="https://pspdftool.svn.sourceforge.net/svnroot/pspdftool/trunk"
ESVN_PROJECT="pspdftool"

[[ "${PV}" == "9999" ]] && EXTRA_ECLASS="subversion"
inherit autotools-utils ${EXTRA_ECLASS}
unset EXTRA_ECLASS

DESCRIPTION="Tool for prepress preparation of PDF and PostScript documents"
HOMEPAGE="http://sourceforge.net/projects/pspdftool"
[[ "${PV}" == "9999" ]] || SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
[[ "${PV}" == "9999" ]] || KEYWORDS="~amd64 ~x86"

LICENSE="GPL-2"
SLOT="0"
IUSE="zlib"

DEPEND="zlib? ( sys-libs/zlib ) "
RDEPEND="${DEPEND}"

src_prepare() {
	eautoreconf
}

src_configure() {
	econf $(use_with zlib)
}

src_install() {
	default
	rm -rf "${ED}"/usr/share/doc/${PN}*
}
