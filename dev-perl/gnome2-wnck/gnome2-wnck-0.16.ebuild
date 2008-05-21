# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/gnome2-wnck/gnome2-wnck-0.16.ebuild,v 1.3 2008/05/21 12:42:28 fmccor Exp $

inherit perl-module eutils

MY_P=Gnome2-Wnck-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Perl interface to the Window Navigator Construction Kit"
SRC_URI="mirror://sourceforge/gtk2-perl/${MY_P}.tar.gz"
HOMEPAGE="http://gtk2-perl.sourceforge.net/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ia64 ~ppc sparc ~x86"
IUSE=""
#SRC_TEST="do"

RDEPEND=">=dev-perl/glib-perl-1.180
	>=dev-perl/gtk2-perl-1.042
	>=x11-libs/libwnck-2.20
	dev-lang/perl"
DEPEND="${RDEPEND}
	>=dev-perl/extutils-pkgconfig-1.03
	dev-util/pkgconfig
	>=dev-perl/extutils-depends-0.2"
