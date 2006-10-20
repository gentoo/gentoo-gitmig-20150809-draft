# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/glib-perl/glib-perl-1.140.ebuild,v 1.4 2006/10/20 23:27:11 agriffis Exp $

inherit perl-module eutils

MY_P=Glib-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Glib - Perl wrappers for the GLib utility and Object libraries"
HOMEPAGE="http://gtk2-perl.sf.net/"
SRC_URI="mirror://cpan/authors/id/T/TS/TSCH/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~hppa ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="xml"
SRC_TEST="do"

RDEPEND=">=x11-libs/gtk+-2
	>=dev-libs/glib-2
	dev-lang/perl
	dev-perl/extutils-pkgconfig
	dev-perl/extutils-depends
	xml? ( dev-perl/XML-Writer
		dev-perl/XML-Parser )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-perl/extutils-depends-0.205
	>=dev-perl/extutils-pkgconfig-1.07"

