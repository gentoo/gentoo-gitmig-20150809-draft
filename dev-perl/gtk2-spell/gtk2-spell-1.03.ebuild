# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/gtk2-spell/gtk2-spell-1.03.ebuild,v 1.1 2003/12/30 17:15:15 mcummings Exp $

inherit perl-module

MY_P=Gtk2-Spell-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Bindings for GtkSpell with Gtk2.x"
SRC_URI="http://search.cpan.org/CPAN/authors/id/M/ML/MLEHMANN/${MY_P}.tar.gz"
HOMEPAGE="http://gtk2-perl.sf.net/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~amd64 ~ppc ~sparc ~alpha ~hppa"

DEPEND="${DEPEND}
	>=x11-libs/gtk+-2*
	>=app-text/gtkspell-2*
	>=dev-perl/glib-perl-1.012
	>=dev-perl/gtk2-perl-1.012"

src_unpack() {
	unpack ${A}
	cd ${S}
	# Without this it cannot find gtkspell <rigo@home.nl>
	sed -ie "s:\#my:my:g" Makefile.PL || die "sed failed"
}
