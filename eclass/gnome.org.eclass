# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/gnome.org.eclass,v 1.1 2002/09/23 16:08:41 spider Exp $

# Authors:
# Spidler <spidler@gentoo.org>
# with help of carparski.

# Gnome ECLASS. mainly SRC_URI settings

ECLASS="gnome"
INHERITED="$INHERITED $ECLASS"

PVP=($(echo " $PV " | sed 's:[-\._]: :g'))
SRC_URI="mirror://gnome/sources/${PN}/${PVP[0]}.${PVP[1]}/${P}.tar.bz2"

