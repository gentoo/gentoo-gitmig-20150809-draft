# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/intltool/intltool-0.32.1.ebuild,v 1.6 2005/04/01 05:37:52 agriffis Exp $

inherit gnome.org

DESCRIPTION="Scripts for extracting translatable strings from various sourcefiles"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~alpha ~amd64 ~arm hppa ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc"
IUSE=""

DEPEND=">=dev-lang/perl-5.6.0
		dev-perl/XML-Parser"

src_install() {

	make DESTDIR=${D} install || die "installation failed"

	dodoc AUTHORS ChangeLog NEWS README TODO INSTALL doc/I18N-HOWTO

}
