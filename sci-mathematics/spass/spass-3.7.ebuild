# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/spass/spass-3.7.ebuild,v 1.1 2012/05/30 00:53:38 gienah Exp $

EAPI="4"

inherit versionator

MY_PV=$(delete_all_version_separators "${PV}")
MY_P="${PN}${MY_PV}"

DESCRIPTION="An Automated Theorem Prover for First-Order Logic with Equality"
HOMEPAGE="http://www.spass-prover.org/"
SRC_URI="http://www.spass-prover.org/download/sources/${MY_P}.tgz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc isabelle"

RDEPEND=""
DEPEND="${RDEPEND}
		isabelle? (
			>=sci-mathematics/isabelle-2011.1-r1
		)"

S="${WORKDIR}/SPASS-${PV}"

src_install() {
	emake DESTDIR="${D}" install

	if use examples; then
		dodir /usr/share/${PN}/examples
		insinto /usr/share/${PN}/examples
		doins -r examples
	fi

	if use isabelle; then
		ISABELLE_HOME="$(isabelle getenv ISABELLE_HOME | cut -d'=' -f 2)" \
			|| die "isabelle getenv ISABELLE_HOME failed"
		if [[ -z "${ISABELLE_HOME}" ]]; then
			die "ISABELLE_HOME empty"
		fi
		dodir "${ISABELLE_HOME}/contrib/${PN}-${PV}/etc"
		cat <<- EOF >> "${S}/settings"
			SPASS_HOME="${ROOT}usr/bin"
			SPASS_VERSION="${PV}"
		EOF
		insinto "${ISABELLE_HOME}/contrib/${PN}-${PV}/etc"
		doins "${S}/settings"
	fi
}

pkg_postinst() {
	if use isabelle; then
		if [ -f "${ROOT}etc/isabelle/components" ]; then
			if egrep "contrib/${PN}-[0-9.]*" "${ROOT}etc/isabelle/components"; then
				sed -e "/contrib\/${PN}-[0-9.]*/d" \
					-i "${ROOT}etc/isabelle/components"
			fi
			cat <<- EOF >> "${ROOT}etc/isabelle/components"
				contrib/${PN}-${PV}
			EOF
		fi
	fi
}

pkg_postrm() {
	if use isabelle; then
		if [ ! -f "${ROOT}usr/bin/SPASS" ]; then
			if [ -f "${ROOT}etc/isabelle/components" ]; then
				# Note: this sed should only match the version of this ebuild
				# Which is what we want as we do not want to remove the line
				# of a new E being installed during an upgrade.
				sed -e "/contrib\/${PN}-${PV}/d" \
					-i "${ROOT}etc/isabelle/components"
			fi
		fi
	fi
}
