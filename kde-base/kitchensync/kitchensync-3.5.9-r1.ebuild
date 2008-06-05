# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kitchensync/kitchensync-3.5.9-r1.ebuild,v 1.1 2008/06/05 23:31:36 loki_val Exp $

KMNAME=kdepim
EAPI="1"
inherit kde-meta eutils

DESCRIPTION="Synchronize Data with KDE"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""
DEPEND=">=app-pda/libopensync-0.36
	>=kde-base/kontact-${PV}:${SLOT}
	>=kde-base/libkcal-${PV}:${SLOT}"

RDEPEND="${DEPEND}"

KMCOPYLIB="
	libkcal libkcal
	libkdepim libkdepim
	libkpinterfaces kontact/interfaces"
KMEXTRACTONLY="
	libkcal/
	libkdepim/
	libkdenetwork/
	kontact/interfaces"

PATCHES=( "${FILESDIR}/${P}-OpenSync0.30API.patch" )

# Disabled by default in kontact/plugins/Makefile.am, so check before enabling - 3.4.0_beta1 -- danarmak
# KMEXTRA="kontact/plugins/kitchensync"
KMEXTRA="kontact/plugins/multisynk"

#src_unpack() {
#	kde-meta_src_unpack
	# disabling tests, see bug #164097
#	sed -e "s:SUBDIRS = . plugins test:SUBDIRS = . plugins:" \
#		-i kitchensync/libkonnector2/Makefile.am || die "sed failed"
#	sed -e "s:SUBDIRS = . tests test:SUBDIRS = .:" \
#		-i kitchensync/libksync/Makefile.am || die "sed failed"
#}
