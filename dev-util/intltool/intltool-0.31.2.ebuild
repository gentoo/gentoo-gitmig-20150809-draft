# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/intltool/intltool-0.31.2.ebuild,v 1.6 2004/11/22 23:35:14 kloeri Exp $

inherit gnome.org

DESCRIPTION="Scripts for extracting translatable strings from various sourcefiles"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 ~arm ~hppa ~ia64 ~mips ppc ~ppc64 ~s390 sparc x86"
IUSE=""

DEPEND=">=dev-lang/perl-5.6.0"
RDEPEND="dev-perl/XML-Parser
	${DEPEND}"

src_install() {

	make DESTDIR=${D} install || die "installation failed"

	dodoc AUTHORS ChangeLog NEWS README TODO INSTALL doc/I18N-HOWTO

}
