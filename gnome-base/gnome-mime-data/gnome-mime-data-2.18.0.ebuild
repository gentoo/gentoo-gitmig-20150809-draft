# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-mime-data/gnome-mime-data-2.18.0.ebuild,v 1.14 2010/10/19 05:32:36 leio Exp $

inherit gnome2

DESCRIPTION="MIME data for Gnome"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc x86 ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""

RDEPEND=""
DEPEND=">=dev-util/pkgconfig-0.12.0
		>=dev-util/intltool-0.35"

DOCS="AUTHORS ChangeLog README"

src_unpack() {
	gnome2_src_unpack

	intltoolize --force || die "intltoolize failed"
}
