# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/gnome.org.eclass,v 1.3 2002/09/28 06:06:49 azarah Exp $

# Authors:
# Spidler <spidler@gentoo.org>
# with help of carparski.

# Gnome ECLASS. mainly SRC_URI settings

ECLASS="gnome.org"
INHERITED="$INHERITED $ECLASS"

[ -z "${GNOME_TARBALL_SUFFIX}" ] && export GNOME_TARBALL_SUFFIX="bz2"
PVP=($(echo " $PV " | sed 's:[-\._]: :g'))
SRC_URI="mirror://gnome/sources/${PN}/${PVP[0]}.${PVP[1]}/${P}.tar.${GNOME_TARBALL_SUFFIX}"

