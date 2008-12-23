# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/perl-tk/perl-tk-804.028.ebuild,v 1.1 2008/12/23 18:54:48 robbat2 Exp $

MODULE_AUTHOR="SREZIC"
MY_P=Tk-${PV}
inherit perl-module eutils multilib

S=${WORKDIR}/${MY_P}
DESCRIPTION="A Perl Module for Tk"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND="x11-libs/libX11
	dev-lang/perl"

myconf="-I/usr/include/ -l/usr/$(get_libdir)"

mydoc="ToDo VERSIONS"

# No test running here, requires an X server, and fails lots anyway.
SRC_TEST="skip"

export X11ROOT=/usr

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/xorg.patch
}
