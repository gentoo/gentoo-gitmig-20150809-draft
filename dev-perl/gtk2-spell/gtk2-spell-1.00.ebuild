# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/gentoo-x86/dev-perl

inherit perl-module

MY_P=Gtk2-Spell-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Bindings for GtkSpell with Gtk2.x"
SRC_URI="http://search.cpan.org/CPAN/authors/id/M/ML/MLEHMANN/${MY_P}.tar.gz"
HOMEPAGE="http://gtk2-perl.sf.net/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha ~hppa"

DEPEND="${DEPEND}
	>=x11-libs/gtk+-2*
	>=app-text/gtkspell-2*
	>=dev-perl/glib-0.26
	>=dev-perl/gtk2-perl-0.26"

src_unpack() {
	unpack ${A}
	cd ${S}
	# Without this it cannot find gtkspell <rigo@home.nl>
	sed -ie "s:\#my:my:g" Makefile.PL || die "sed failed"
}
