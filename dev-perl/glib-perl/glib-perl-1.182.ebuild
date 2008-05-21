# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/glib-perl/glib-perl-1.182.ebuild,v 1.2 2008/05/21 12:40:28 fmccor Exp $

inherit perl-module

MY_P=Glib-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Glib - Perl wrappers for the GLib utility and Object libraries"
HOMEPAGE="http://gtk2-perl.sf.net/"
SRC_URI="mirror://cpan/authors/id/T/TS/TSCH/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 sparc ~x86"
IUSE=""
# 080408 - can't find where the xml stuff is used -- tove
#IUSE="xml"

RDEPEND=">=dev-libs/glib-2
	dev-lang/perl"
#	xml? ( dev-perl/XML-Writer
#		dev-perl/XML-Parser )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-perl/extutils-pkgconfig-1.0
	>=dev-perl/extutils-depends-0.300"

SRC_TEST="do"
