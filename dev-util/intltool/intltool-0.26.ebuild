# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/intltool/intltool-0.26.ebuild,v 1.1 2003/05/17 14:59:53 foser Exp $

inherit gnome.org

S=${WORKDIR}/${P}
DESCRIPTION="Scripts for extracting translatable strings from various sourcefiles"
HOMEPAGE="http://www.gnome.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~mips"

DEPEND=">=dev-lang/perl-5.6.0"

src_compile() {                           
	econf || die "configure failed" 
	emake || die "compile failed" 
}

src_install() {
	einstall || die "installation failed"
	dodoc AUTHORS ChangeLog NEWS README TODO COPYING INSTALL
	dodoc doc/I18N-HOWTO
}
