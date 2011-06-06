# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/kde4-meta-pkg.eclass,v 1.3 2011/06/06 21:38:18 abcd Exp $

# @ECLASS: kde4-meta-pkg.eclass
# @MAINTAINER:
# kde@gentoo.org
# @BLURB: This eclass contains boilerplate for kde 4.X meta packages
# @DESCRIPTION:
# This eclass should only be used for defining meta packages for KDE4.

inherit kde4-functions versionator

HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
IUSE="aqua"

# Only add the kdeprefix USE flag for older versions, to help
# non-portage package managers handle the upgrade
if [[ ${PV} < 4.6.4 ]]; then
	IUSE+=" kdeprefix"
fi

SLOT=$(_calculate_kde_slot)
[[ -z ${SLOT} ]] && die "Unsupported ${PV}"

RDEPEND="$(block_other_slots)"
