# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome2-user-docs/gnome2-user-docs-2.6.0.ebuild,v 1.1 2004/03/23 16:36:21 foser Exp $

inherit gnome2

DESCRIPTION="end user documentation"
HOMEPAGE="http://www.gnome.org"
LICENSE="FDL-1.1"

SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64 ~ia64 ~mips"

DEPEND=">=app-text/scrollkeeper-0.3.11"

DOCS="AUTHORS COPYING* ChangeLog INSTALL NEWS README"
