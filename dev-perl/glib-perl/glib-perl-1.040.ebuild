# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/glib-perl/glib-perl-1.040.ebuild,v 1.2 2004/04/07 00:43:43 gustavoz Exp $

inherit perl-module

MY_P=Glib-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Glib - Perl wrappers for the GLib utility and Object libraries"
HOMEPAGE="http://gtk2-perl.sf.net/"
SRC_URI="http://www.cpan.org/authors/id/R/RM/RMCFARLA/Gtk2-Perl/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc sparc ~alpha hppa ~amd64"
IUSE="xml"

RDEPEND=">=x11-libs/gtk+-2*
	>=dev-libs/glib-2*
	xml? ( dev-perl/XML-Writer
		dev-perl/XML-Parser )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-perl/extutils-depends-0.2*
	dev-perl/extutils-pkgconfig"
