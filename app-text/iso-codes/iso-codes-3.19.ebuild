# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/iso-codes/iso-codes-3.19.ebuild,v 1.5 2010/10/10 15:33:40 armin76 Exp $

EAPI="2"

inherit eutils

DESCRIPTION="Provides the list of country and language names"
HOMEPAGE="http://alioth.debian.org/projects/pkg-isocodes/"
SRC_URI="ftp://pkg-isocodes.alioth.debian.org/pub/pkg-isocodes/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm ~hppa ia64 ~ppc ppc64 sh sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE=""

RDEPEND=""
DEPEND="sys-devel/gettext"

src_prepare() {
	local linguas_bak=${LINGUAS}
	local mylinguas=""

	for norm in iso_15924 iso_3166 iso_3166_2 iso_4217 iso_639 iso_639_3; do
		einfo "Preparing ${norm}"

		mylinguas=""
		LINGUAS=${linguas_bak}
		strip-linguas -i "${S}/${norm}"

		for loc in ${LINGUAS}; do
			mylinguas="${mylinguas} ${loc}.po"
		done

		if [ -n "${mylinguas}" ]; then
			sed -e "s:pofiles =.*:pofiles = ${mylinguas}:" \
				-e "s:mofiles =.*:mofiles = ${mylinguas//.po/.mo}:" \
				-i "${S}/${norm}/Makefile.am" "${S}/${norm}/Makefile.in" \
				|| die "sed in ${norm} folder failed"
		fi
	done
}

src_install() {
	emake DESTDIR="${D}" install || die "Installation failed"

	dodoc ChangeLog README TODO || die "dodoc failed"
}
