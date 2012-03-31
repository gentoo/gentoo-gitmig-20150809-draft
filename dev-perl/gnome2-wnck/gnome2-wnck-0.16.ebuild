# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/gnome2-wnck/gnome2-wnck-0.16.ebuild,v 1.10 2012/03/31 12:07:16 armin76 Exp $

EAPI="1"

inherit perl-module eutils

MY_P=Gnome2-Wnck-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Perl interface to the Window Navigator Construction Kit"
SRC_URI="mirror://sourceforge/gtk2-perl/${MY_P}.tar.gz"
HOMEPAGE="http://gtk2-perl.sourceforge.net/"
SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="amd64 ppc x86"
IUSE=""
#SRC_TEST="do"

RDEPEND=">=dev-perl/glib-perl-1.180
	>=dev-perl/gtk2-perl-1.042
	>=x11-libs/libwnck-2.20:1
	dev-lang/perl"
DEPEND="${RDEPEND}
	>=dev-perl/extutils-pkgconfig-1.03
	dev-util/pkgconfig
	>=dev-perl/extutils-depends-0.2"
