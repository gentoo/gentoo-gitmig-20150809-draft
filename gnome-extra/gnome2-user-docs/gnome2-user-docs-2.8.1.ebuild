# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome2-user-docs/gnome2-user-docs-2.8.1.ebuild,v 1.9 2005/04/02 05:03:16 geoman Exp $

inherit gnome2

DESCRIPTION="end user documentation"
HOMEPAGE="http://www.gnome.org"

LICENSE="FDL-1.1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc s390 sparc x86"
IUSE=""

DEPEND=">=app-text/scrollkeeper-0.3.11"

DOCS="AUTHORS ChangeLog NEWS README"
