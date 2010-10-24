# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/bibtexu/bibtexu-3.71_p20100722.ebuild,v 1.1 2010/10/24 17:12:48 aballier Exp $

EAPI=3

DESCRIPTION="8-bit Implementation of BibTeX 0.99 with a Very Large Capacity"
HOMEPAGE="http://tug.org/texlive/"
SRC_URI="mirror://gentoo/texlive-${PV#*_p}-source.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-libs/kpathsea
		>=dev-libs/icu-4.4"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/texlive-${PV#*_p}-source/texk/${PN}

src_configure() {
	econf --with-system-kpathsea \
		--with-system-icu
}

src_install() {
	emake \
		DESTDIR="${D}" \
		csfdir="/usr/share/texmf-dist/bibtexu/csf/base" \
		btdocdir="/usr/share/doc/${PF}" \
		install || die
	dodoc 00readme.txt ChangeLog csfile.txt HISTORY || die
}
