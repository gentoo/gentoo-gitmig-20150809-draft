# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/gnome.org.eclass,v 1.4 2003/02/16 04:26:21 vapier Exp $
#
# Authors:
# Spidler <spidler@gentoo.org>
# with help of carparski.
#
# Gnome ECLASS. mainly SRC_URI settings

ECLASS="gnome.org"
INHERITED="$INHERITED $ECLASS"

[ -z "${GNOME_TARBALL_SUFFIX}" ] && export GNOME_TARBALL_SUFFIX="bz2"
PVP=($(echo " $PV " | sed 's:[-\._]: :g'))
SRC_URI="mirror://gnome/sources/${PN}/${PVP[0]}.${PVP[1]}/${P}.tar.${GNOME_TARBALL_SUFFIX}"

