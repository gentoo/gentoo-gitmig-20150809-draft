# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-mime-data/gnome-mime-data-2.4.2.ebuild,v 1.13 2006/07/05 06:02:06 vapier Exp $

inherit gnome2

DESCRIPTION="MIME data for Gnome"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sh sparc x86"
IUSE=""

DEPEND=">=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.29"
RDEPEND=""

DOCS="AUTHORS ChangeLog README"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e 's:libdir=${exec_prefix}/lib:libdir=@libdir@:' \
		${PN}-2.0.pc.in || die 'sed-ing pkgconfig-file failed'
}
