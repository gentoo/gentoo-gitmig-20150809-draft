# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/gnome2-perl/gnome2-perl-0.30.ebuild,v 1.4 2004/07/14 17:40:19 agriffis Exp $

inherit perl-module

MY_P=Gnome2-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Perl interface to the 2.x series of the Gnome libraries."
SRC_URI="mirror://sourceforge/gtk2-perl/${MY_P}.tar.gz"
HOMEPAGE="http://gtk2-perl.sf.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~sparc ~ppc ~alpha"
IUSE=""

DEPEND="${DEPEND}
	>=x11-libs/gtk+-2*
	>=gnome-base/libgnome-2*
	>=gnome-base/libgnomeprint-2*
	>=dev-perl/gtk2-perl-${PV}"
