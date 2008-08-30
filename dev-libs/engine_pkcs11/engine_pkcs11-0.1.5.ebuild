# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/engine_pkcs11/engine_pkcs11-0.1.5.ebuild,v 1.1 2008/08/30 05:12:15 dragonheart Exp $

DESCRIPTION="engine_pkcs11 is an implementation of an engine for OpenSSL"
HOMEPAGE="http://www.opensc-project.org/engine_pkcs11"

if [[ "${PV}" = "9999" ]]; then
	inherit subversion autotools
	ESVN_REPO_URI="http://www.opensc-project.org/svn/${PN}/trunk"
	KEYWORDS=""
else
	SRC_URI="http://www.opensc-project.org/files/${PN}/${P}.tar.gz"
	KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
fi

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="doc"

DEPEND=">=dev-libs/libp11-0.2.4
	dev-libs/openssl"
RDEPEND="${DEPEND}"

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
		|| die
	emake || die
}

src_install() {
	emake install DESTDIR="${D}" || die
}
