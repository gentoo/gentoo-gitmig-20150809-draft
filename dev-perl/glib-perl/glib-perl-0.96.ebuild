# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/glib-perl/glib-perl-0.96.ebuild,v 1.1 2003/09/08 08:48:31 mcummings Exp $

inherit perl-module

MY_P=Glib-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Glib - Perl wrappers for the GLib utility and Object libraries"
SRC_URI="http://search.cpan.org/CPAN/authors/id/M/ML/MLEHMANN/${MY_P}.tar.gz"
HOMEPAGE="http://gtk2-perl.sf.net/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha ~hppa"
IUSE="xml"

DEPEND="${DEPEND}
	>=x11-libs/gtk+-2*
	>=dev-libs/glib-2*
	dev-util/pkgconfig
	dev-perl/extutils-depends
	xml? ( dev-perl/XML-Writer
		dev-perl/XML-Parser )"
