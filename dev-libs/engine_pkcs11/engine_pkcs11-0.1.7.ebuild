# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/engine_pkcs11/engine_pkcs11-0.1.7.ebuild,v 1.4 2009/12/08 19:21:08 nixnut Exp $

EAPI="2"

if [[ "${PV}" = "9999" ]]; then
	inherit autotools subversion
	ESVN_REPO_URI="http://www.opensc-project.org/svn/${PN}/trunk"
else
	inherit eutils
	SRC_URI="http://www.opensc-project.org/files/${PN}/${P}.tar.gz"
fi

DESCRIPTION="engine_pkcs11 is an implementation of an engine for OpenSSL"
HOMEPAGE="http://www.opensc-project.org/engine_pkcs11"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha amd64 hppa ~ia64 ppc ~ppc64 ~sparc x86"
IUSE="doc"

DEPEND=">=dev-libs/libp11-0.2.5
	dev-libs/openssl"
RDEPEND="${DEPEND}"

if [[ "${PV}" = "9999" ]]; then
	DEPEND="${DEPEND}
		app-text/docbook-xsl-stylesheets
		dev-libs/libxslt"

	src_prepare() {
		eautoreconf
	}
else
	src_prepare() {
		epatch "${FILESDIR}/${PN}-0.1.6-fix_implicit_declaration.patch"
	}
fi

src_configure() {
	econf \
		--docdir="/usr/share/doc/${PF}" \
		--htmldir="/usr/share/doc/${PF}/html" \
		$(use_enable doc)
}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"
}
