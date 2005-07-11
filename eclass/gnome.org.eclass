# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/gnome.org.eclass,v 1.10 2005/07/11 15:08:06 swegener Exp $
#
# Authors:
# Spidler <spidler@gentoo.org>
# with help of carparski.
#
# Gnome ECLASS. mainly SRC_URI settings


[ -z "${GNOME_TARBALL_SUFFIX}" ] && export GNOME_TARBALL_SUFFIX="bz2"
PVP=(${PV//[-\._]/ })
SRC_URI="mirror://gnome/sources/${PN}/${PVP[0]}.${PVP[1]}/${P}.tar.${GNOME_TARBALL_SUFFIX}"
