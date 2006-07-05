# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/gtk2-gladexml/gtk2-gladexml-0.94.ebuild,v 1.9 2006/07/05 17:34:04 ian Exp $

inherit perl-module

MY_P=Gtk2-GladeXML-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Perl wrappers for the Gtk2::GladeXML utilities."
SRC_URI="mirror://cpan/authors/id/M/ML/MLEHMANN/${MY_P}.tar.gz"
HOMEPAGE="http://gtk2-perl.sf.net/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~amd64 ppc sparc ~alpha ~hppa"
IUSE=""

DEPEND=">=x11-libs/gtk+-2
	>=gnome-base/libglade-2
	>=dev-perl/glib-perl-1.012
	>=dev-perl/gtk2-perl-1.012
	dev-perl/extutils-depends
	dev-perl/extutils-pkgconfig"
RDEPEND="${DEPEND}"