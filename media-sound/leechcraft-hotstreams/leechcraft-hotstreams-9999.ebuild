# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/leechcraft-hotstreams/leechcraft-hotstreams-9999.ebuild,v 1.2 2012/09/04 17:34:37 pinkbyte Exp $

EAPI="4"

inherit eutils leechcraft toolchain-funcs

DESCRIPTION="Provides some cool radio streams to music players like LMP"

SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="~net-misc/leechcraft-core-${PV}
	dev-libs/qjson"
RDEPEND="${DEPEND}"

# TODO: Maybe simplify this or add apropriate function to leechcraft eclass?
pkg_pretend() {
	if [[ ${MERGE_TYPE} != binary ]]; then
		[[ $(gcc-major-version) -lt 4 ]] || \
				( [[ $(gcc-major-version) -eq 4 && $(gcc-minor-version) -lt 6 ]] ) \
			&& die "Sorry, but gcc 4.6 or higher is required."
	fi
}
