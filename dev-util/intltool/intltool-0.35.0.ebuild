# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/intltool/intltool-0.35.0.ebuild,v 1.11 2006/10/19 14:44:23 kloeri Exp $

inherit gnome.org

DESCRIPTION="Tools for extracting translatable strings from various sourcefiles"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ~ppc-macos ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

DEPEND=">=dev-lang/perl-5.6
	dev-perl/XML-Parser"
RDEPEND="${DEPEND}"

src_install() {
	make DESTDIR="${D}" install || die "Installation failed"

	dodoc AUTHORS ChangeLog NEWS README TODO doc/I18N-HOWTO
}
