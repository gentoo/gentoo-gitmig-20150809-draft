# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-gnustep/gnumail/gnumail-1.1.0_pre2.ebuild,v 1.1 2003/07/15 08:09:24 raker Exp $

inherit gnustep

newdepend dev-util/gnustep-gui
newdepend app-gnustep/pantomime

S=${WORKDIR}/GNUMail
A=GNUMail-${PV/_/}.tar.gz

DESCRIPTION="A fully featured mail application for GNUstep"
HOMEPAGE="http://www.collaboration-world.com/gnumail/"
LICENSE="GPL-2"
DEPEND="${DEPEND}"
RDEPEND="${RDEPEND} dev-util/gnustep-back"
SRC_URI="http://www.collaboration-world.com/gnumail.data/releases/Stable/GNUMail-${PV/_/}.tar.gz"
KEYWORDS="x86"
SLOT="0"
