# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/gnome.org.eclass,v 1.11 2011/03/18 07:58:09 eva Exp $

# @ECLASS: gnome.org.eclass
# @MAINTAINER:
# gnome@gentoo.org
#
# @CODE@
# Authors: Spidler <spidler@gentoo.org> with help of carparski.
# eclass variable additions and documentation: Gilles Dartiguelongue <eva@gentoo.org>
# @CODE@
# @BLURB: Helper eclass for gnome.org hosted archives
# @DESCRIPTION:
# Provide a default SRC_URI for tarball hosted on gnome.org mirrors.

inherit versionator

# @ECLASS-VARIABLE: GNOME_TARBALL_SUFFIX
# @DESCRIPTION:
# Most projects hosted on gnome.org mirrors provide tarballs as tar.gz or
# tar.bz2. This eclass defaults to bz2 which is often smaller in size.
: ${GNOME_TARBALL_SUFFIX:="bz2"}

# @ECLASS-VARIABLE: GNOME_ORG_MODULE
# @DESCRIPTION:
# Name of the module as hosted on gnome.org mirrors.
# Leave unset if package name matches module name.
: ${GNOME_ORG_MODULE:=$PN}

# @ECLASS-VARIABLE: GNOME_ORG_PVP
# @INTERNAL
# @DESCRIPTION:
# Major and minor numbers of the version number.
: ${GNOME_ORG_PVP:=$(get_version_component_range 1-2)}

SRC_URI="mirror://gnome/sources/${GNOME_ORG_MODULE}/${GNOME_ORG_PVP}/${GNOME_ORG_MODULE}-${PV}.tar.${GNOME_TARBALL_SUFFIX}"

S="${WORKDIR}/${GNOME_ORG_MODULE}-${PV}"
