# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/leechcraft-launchy/leechcraft-launchy-0.5.85.ebuild,v 1.1 2012/10/08 15:58:15 pinkbyte Exp $

EAPI="4"

inherit leechcraft toolchain-funcs

DESCRIPTION="Allows one to launch third-party applications (as well as LeechCraft plugins) from LeechCraft"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="~net-misc/leechcraft-core-${PV}
	x11-libs/qt-declarative:4"
RDEPEND="${DEPEND}
	~virtual/leechcraft-trayarea-${PV}"

# TODO: Maybe simplify this or add apropriate function to leechcraft eclass?
pkg_pretend() {
	if [[ ${MERGE_TYPE} != binary ]]; then
		[[ $(gcc-major-version) -lt 4 ]] || \
				( [[ $(gcc-major-version) -eq 4 && $(gcc-minor-version) -lt 6 ]] ) \
			&& die "Sorry, but gcc 4.6 or higher is required."
	fi
}
