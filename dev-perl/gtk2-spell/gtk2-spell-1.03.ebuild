# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/gtk2-spell/gtk2-spell-1.03.ebuild,v 1.14 2007/07/10 23:33:27 mr_bones_ Exp $

inherit perl-module

MY_P=Gtk2-Spell-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Bindings for GtkSpell with Gtk2.x"
SRC_URI="mirror://cpan/authors/id/M/ML/MLEHMANN/${MY_P}.tar.gz"
HOMEPAGE="http://gtk2-perl.sf.net/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 ~hppa ia64 ~ppc sparc x86"
IUSE=""

DEPEND=">=x11-libs/gtk+-2
	>=app-text/gtkspell-2
	>=dev-perl/glib-perl-1.012
	>=dev-perl/gtk2-perl-1.012
	dev-lang/perl"

src_unpack() {
	unpack ${A}
	cd ${S}
	# Without this it cannot find gtkspell <rigo@home.nl>
	sed -ie "s:\#my:my:g" Makefile.PL || die "sed failed"
}
