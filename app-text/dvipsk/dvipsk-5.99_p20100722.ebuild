# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/dvipsk/dvipsk-5.99_p20100722.ebuild,v 1.8 2011/02/27 15:57:53 armin76 Exp $

EAPI=3

inherit texlive-common

DESCRIPTION="DVI-to-PostScript translator"
HOMEPAGE="http://tug.org/texlive/"
SRC_URI="mirror://gentoo/texlive-${PV#*_p}-source.tar.xz"

TL_VERSION=2010
EXTRA_TL_MODULES="dvips"
EXTRA_TL_DOC_MODULES="dvips.doc"

for i in ${EXTRA_TL_MODULES} ; do
	SRC_URI="${SRC_URI} mirror://gentoo/texlive-module-${i}-${TL_VERSION}.tar.xz"
done

SRC_URI="${SRC_URI} doc? ( "
for i in ${EXTRA_TL_DOC_MODULES} ; do
	SRC_URI="${SRC_URI} mirror://gentoo/texlive-module-${i}-${TL_VERSION}.tar.xz"
done
SRC_URI="${SRC_URI} ) "

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE="doc source"

DEPEND="dev-libs/kpathsea"
RDEPEND="
	!<app-text/texlive-core-2010
	!<dev-texlive/texlive-basic-2009
	!app-text/ptex
	${DEPEND}"

S=${WORKDIR}/texlive-${PV#*_p}-source/texk/${PN}

src_configure() {
	econf --with-system-kpathsea
}

src_install() {
	emake DESTDIR="${D}" prologdir="${EPREFIX}/usr/share/texmf/dvips/base" install || die

	dodir /usr/share # just in case
	cp -pR "${WORKDIR}"/texmf "${ED}/usr/share/" || die "failed to install texmf trees"
	cp -pR "${WORKDIR}"/texmf-dist "${ED}/usr/share/" || die "failed to install texmf trees"
	if use source ; then
		cp -pR "${WORKDIR}"/tlpkg "${ED}/usr/share/" || die "failed to install tlpkg files"
	fi

	dodoc AUTHORS ChangeLog NEWS README TODO || die
}

pkg_postinst() {
	etexmf-update
}

pkg_postrm() {
	etexmf-update
}
