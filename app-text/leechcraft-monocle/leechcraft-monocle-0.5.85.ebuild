# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/leechcraft-monocle/leechcraft-monocle-0.5.85.ebuild,v 1.1 2012/10/08 15:50:29 pinkbyte Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="Monocle, the modular document viewer for LeechCraft."

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+djvu debug +fb2 +pdf"

DEPEND="~net-misc/leechcraft-core-${PV}
	pdf? ( app-text/poppler[qt4] )
	djvu? ( app-text/djvu )"
RDEPEND="${DEPEND}"

# TODO: Maybe simplify this or add apropriate function to leechcraft eclass?
pkg_pretend() {
	if [[ ${MERGE_TYPE} != binary ]]; then
		[[ $(gcc-major-version) -lt 4 ]] || \
				( [[ $(gcc-major-version) -eq 4 && $(gcc-minor-version) -lt 6 ]] ) \
			&& die "Sorry, but gcc 4.6 or higher is required."
	fi
}

src_configure() {
	local mycmakeargs="
		$(cmake-utils_use_enable djvu MONOCLE_SEEN)
		$(cmake-utils_use_enable fb2 MONOCLE_FXB)
		$(cmake-utils_use_enable pdf MONOCLE_PDF)"

	cmake-utils_src_configure
}
