# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome2-user-docs/gnome2-user-docs-2.4.0.ebuild,v 1.3 2003/10/17 13:31:16 agriffis Exp $

inherit gnome2

DESCRIPTION="end user documentation for Gnome2"
HOMEPAGE="http://www.gnome.org"

LICENSE="FDL-1.1"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc alpha"

DEPEND="virtual/glibc
	>=app-text/scrollkeeper-0.3.11"

S=${WORKDIR}/${P}
