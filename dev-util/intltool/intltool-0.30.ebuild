# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/intltool/intltool-0.30.ebuild,v 1.4 2004/02/16 18:07:59 gustavoz Exp $

inherit gnome.org

DESCRIPTION="Scripts for extracting translatable strings from various sourcefiles"
HOMEPAGE="http://www.gnome.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc sparc ~alpha hppa ~mips ~amd64 ~ia64"

DEPEND=">=dev-lang/perl-5.6.0"

RDEPEND="dev-perl/XML-Parser
	${DEPEND}"

src_compile() {

	econf || die "configure failed"
	emake || die "compile failed"

}

src_install() {

	einstall || die "installation failed"

	dodoc AUTHORS ChangeLog NEWS README TODO COPYING INSTALL doc/I18N-HOWTO

}
