# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libp11/libp11-0.2.4.ebuild,v 1.7 2009/05/14 21:08:02 maekke Exp $

DESCRIPTION="a lib implementing a small layer on top of PKCS#11 API to make using PKCS#11 implementations easier."
HOMEPAGE="http://www.opensc-project.org/libp11/"

if [[ "${PV}" = "9999" ]]; then
	inherit subversion autotools
	ESVN_REPO_URI="http://www.opensc-project.org/svn/${PN}/trunk"
	KEYWORDS=""
else
	SRC_URI="http://www.opensc-project.org/files/${PN}/${P}.tar.gz"
	KEYWORDS="alpha amd64 ~hppa ~ia64 ~ppc ~ppc64 sparc x86"
fi

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="doc"

RDEPEND=""
DEPEND="dev-util/pkgconfig
	doc? ( app-doc/doxygen )"

[[ "${PV}" = "9999" ]] && DEPEND="${DEPEND}
	app-text/docbook-xsl-stylesheets
	dev-libs/libxslt"

src_unpack() {
	if [ "${PV}" = "9999" ]; then
		subversion_src_unpack
		cd "${S}"
		eautoreconf
	else
		unpack ${A}
		cd "${S}"
	fi
}

src_compile() {
	econf \
		--docdir="/usr/share/doc/${PF}" \
		--htmldir="/usr/share/doc/${PF}/html" \
		$(use_enable doc) \
		$(use_enable doc api-doc) \
		|| die
	emake || die
}

src_install() {
	emake install DESTDIR="${D}" || die
}
