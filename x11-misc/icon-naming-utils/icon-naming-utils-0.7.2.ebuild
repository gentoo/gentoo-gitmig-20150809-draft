# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/icon-naming-utils/icon-naming-utils-0.7.2.ebuild,v 1.5 2006/07/05 05:58:19 vapier Exp $

DESCRIPTION="Utilities to help with the transition to the new freedesktop.org naming scheme, they will map the new names to the legacy names used by the GNOME and KDE desktops."
HOMEPAGE="http://tango-project.org/"
SRC_URI="http://tango-project.org/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ppc ppc64 ~sh ~sparc ~x86"
IUSE=""

RDEPEND=">=dev-perl/XML-Simple-2
	 dev-lang/perl"

DEPEND="${RDEPEND}"

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog NEWS README
}
